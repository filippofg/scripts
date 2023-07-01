#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <sys/sysinfo.h>

int main (int argc, char** argv) {
    //char* icons = { "", "", "", "" };
    
    char   status[12];
    int	   capacity;
    time_t rawtime;
    struct tm *dt;
    char   datetime[22];

    FILE *bat_status   = fopen("/sys/class/power_supply/BAT0/status", "r");
    FILE *bat_capacity = fopen("/sys/class/power_supply/BAT0/capacity", "r");

    while (1) {
	// Read the current battery status
	fscanf(bat_status, "%s", status);
	rewind(bat_status);
	fflush(bat_status);

	// Read the battery capacity
	fscanf(bat_capacity, "%d", &capacity);
	rewind(bat_capacity);
	fflush(bat_capacity);
	
	// Current datetime
	rawtime = time(NULL);
	dt = localtime(&rawtime);
	strftime(datetime, 22, "%Y-%m-%d | %H:%M:%S", dt);

	// Print status
	fprintf(stderr, "Battery %d%% %s :: %s :: \n", capacity, status, datetime);
	// Wait 1s
	sleep(1);
    }
    fclose(bat_status);
    fclose(bat_capacity);

    exit(0);
}
