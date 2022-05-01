# r2cloud-apt-decoder
Decodes dernasherbrezon/r2cloud NOAA data into custom folder.

**Change .bash to your need!!**


Workflow:

- **Checks if a done.mark file exists**, if it does not, continue. Else, sleep 1200, and check it again until it does.
- **Declares variables**, which you must modify depending on your needs.
- **Creates folders (if needed)** in /var/www/html/data/noaa.
- **Copies raw audio file** from r2cloud data to /var/www/html/data/noaa/(timestamp)
- **Decodes raw audio file** with 4 contrasts.
- **Creates a done.mark file**, which confirms that the task has been done
- **Repeat**.


This just complements **_dernasherbrezon_**'s work.

Requierements:
- bash
- noaa-apt
- apache2 or nginx
