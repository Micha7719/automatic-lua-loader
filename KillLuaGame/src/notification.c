#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "notification.h"

typedef struct {
  char unused[45];
  char message[3075];
} notify_request_t;

int sceKernelSendNotificationRequest(int, notify_request_t*, size_t, int);

void send_notification(const char *fmt, ...) {
  notify_request_t req = {0};
  va_list args;
  va_start(args, fmt);
  vsnprintf(req.message, sizeof(req.message), fmt, args);
  va_end(args);
  sceKernelSendNotificationRequest(0, &req, sizeof req, 0);
}
