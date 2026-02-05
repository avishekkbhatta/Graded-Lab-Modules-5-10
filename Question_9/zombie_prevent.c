#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid;
    int i;
    int num_children = 3;

    printf("Parent Process (PID: %d) creating %d children...\n", getpid(), num_children);

    // 1. Create multiple child processes
    for (i = 0; i < num_children; i++) {
        pid = fork();

        if (pid < 0) {
            perror("Fork failed");
            exit(1);
        } else if (pid == 0) {
            // --- CHILD PROCESS ---
            printf("  [Child] PID: %d is running...\n", getpid());
            sleep(1); // Simulate some work
            printf("  [Child] PID: %d is exiting.\n", getpid());
            exit(0); // Child terminates here
        }
    }

    // 2. Parent waits for all children to prevent zombies
    int status;
    pid_t child_pid;

    // wait() returns the PID of the terminated child.
    // We loop until wait() returns -1 (meaning no children are left).
    while ((child_pid = wait(&status)) > 0) {
        printf("Parent: Cleaned up zombie process (PID: %d)\n", child_pid);
    }

    printf("Parent: All children cleaned up. Exiting.\n");
    return 0;
}
