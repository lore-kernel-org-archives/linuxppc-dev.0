From: Arun Dharankar <ADharankar@attbi.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Module parameters for cmdlinepart MTD module
Date: Sat, 12 Apr 2003 20:35:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304122035.05858.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings...

Are there any enhancements made to the "cmdlinepart" module to
pass the flash paritioning information via insmod/modprobe command
line arguments?

I am aware of:
  - configuring the driver to be statically linked driver into the
    Linux kernel, then passing partitioning information via the bootloader.
  - hardcoding the partitioning information into the driver.
But would like to avoid using these two.

Best regards,
-Arun.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
