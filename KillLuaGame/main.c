#include <sys/types.h>
#include <sys/user.h>
#include <sys/sysctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>

#include "src/notification.h"


typedef struct app_info {
  uint32_t app_id;
  uint64_t unknown1;
  uint32_t app_type;
  char     title_id[10];
  char     unknown2[0x3c];
} app_info_t;

int sceKernelGetAppInfo(pid_t pid, app_info_t *info);

const char *lua_games[] = {"16074", "17068", "27389", "27390", "16229", "19556", "17112", "13303"};
#define NUM_TITLES (sizeof(lua_games) / sizeof(lua_games[0]))


int main() {
  int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_PROC, 0};
  app_info_t appinfo;
  size_t buf_size;
  void *buf;
  pid_t target_pid = -1;

  if (sysctl(mib, 4, NULL, &buf_size, NULL, 0)) {
    perror("sysctl");
    return 1;
  }

  if (!(buf = malloc(buf_size))) {
    perror("malloc");
    return 1;
  }

  if (sysctl(mib, 4, buf, &buf_size, NULL, 0)) {
    perror("sysctl");
    free(buf);
    return 1;
  }

  for (void *ptr = buf; ptr < (buf + buf_size);) {
    struct kinfo_proc *ki = (struct kinfo_proc *)ptr;
    if (ki->ki_structsize < sizeof(struct kinfo_proc) ||
        (ptr + ki->ki_structsize) > (buf + buf_size)) {
      break;
    }

    if (sceKernelGetAppInfo(ki->ki_pid, &appinfo)) {
      memset(&appinfo, 0, sizeof(appinfo));
    }

    for (size_t i = 0; i < NUM_TITLES; i++) {
      if (strncmp(appinfo.title_id, lua_games[i], 9) == 0) {
        target_pid = ki->ki_pid;
        break;
      }
    }
    if (target_pid != -1) break;

    ptr += ki->ki_structsize;
  }

  free(buf);

  if (target_pid == -1) {
    printf("No matching process found.\n");
    send_notification("No matching process found.");
    return 1;
  }

  if (kill(target_pid, SIGTERM)) {
    if (errno == EPERM) {
      if (kill(target_pid, SIGKILL)) {
        perror("kill(SIGKILL)");
        send_notification("Failed to send SIGKILL.");
        return 1;
      }
      printf("Sent SIGKILL to PID %d\n", target_pid);
      send_notification("Sent SIGKILL to process.");
    } else {
      perror("kill(SIGTERM)");
      send_notification("Failed to send SIGTERM.");
      return 1;
    }
  } else {
    printf("Successfully sent SIGTERM to PID %d, Title ID CUSA%s\n", target_pid, appinfo.title_id);
    send_notification("Killed process: PID %d\nTitle ID: CUSA%s", target_pid, appinfo.title_id);
  }

  return 0;
}