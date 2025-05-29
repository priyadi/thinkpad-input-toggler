#include <linux/input.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

int main() {
    struct input_event ev;

    while (read(STDIN_FILENO, &ev, sizeof(ev)) == sizeof(ev)) {
        if (ev.type == EV_KEY && ev.value == 1) {  // Key press
            if (ev.code == KEY_BOOKMARKS) {
                system("/usr/local/lib/input-toggler/input-toggler.sh"); 
            }
        }
    }

    return 0;
}