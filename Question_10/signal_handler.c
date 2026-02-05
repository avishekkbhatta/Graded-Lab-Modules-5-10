#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>

// 1. Define Signal Handlers
void handle_sigterm(int sig) {
    printf("\n[Parent] Received SIGTERM (Signal %d). I will continue running...\n", sig);
}

void handle_sigint(int sig) {
    printf("\n[Parent] Received SIGINT (Signal %d). Exiting gracefully now.\n", sig);
    exit(0);
}

int main() {
    pid_t pid1, pid2;
    pid_t parent_pid = getpid();

    printf("Parent Process (PID: %d) started. Waiting for signals...\n", parent_pid);

    // 2. Register Signal Handlers
    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    // 3. Create First Child (Sends SIGTERM after 5s)
    pid1 = fork();
    if (pid1 == 0) {
        sleep(5);
        printf("  [Child 1] Sending SIGTERM to parent...\n");
        kill(parent_pid, SIGTERM);
        exit(0);
    }

    // 4. Create Second Child (Sends SIGINT after 10s)
    pid2 = fork();
    if (pid2 == 0) {
        sleep(10);
        printf("  [Child 2] Sending SIGINT to parent...\n");
        kill(parent_pid, SIGINT);
        exit(0);
    }

    // 5. Parent runs indefinitely waiting for signals
    while (1) {
        sleep(1); 
    }

    return 0;
}
