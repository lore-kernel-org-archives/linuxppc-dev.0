From: Arun Dharankar <ADharankar@attbi.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux kernel panics and core dumps.
Date: Tue, 8 Apr 2003 11:58:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304081158.29606.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings.

On x86 architectures there seem to be at least two ways of
producing  Linux kernel panic dumps. These projects are
hosted at

    "http://lkcd.sourceforge.net/" (originated in SGI), and

    "http://oss.missioncriticallinux.com/projects/mcore/"
        (originated in MCLX).


Of the two, the second one seems to work quite well on x86
PCs. I dont know how much of it is actively supported on
PowerPCs. So, the first question is:

    Has anyone tried this on PowerPC, specifically Linux
    kernel versions 2.4.x? The code for PowerPC seems to
    be there, but the Makefiles dont seem to be up-to-date,
    and could be broken.

Further more, this same project has some documentation
which has a good discussion on different approaches to Linux
kernel memory dumps. One item in this discussion is about
the BIOS/bootloader support.


Essentially, if PPCBoot/U-Boot was to recognize the Linux
kernel memory layout, a much more reliable scheme could
be implemented. For example, under all panic or hang
conditions (watchdog), the system could just be rebooted.
During the startup, PPCBoot/U-Boot along with Linux, could
save the Linux kernel dump reliably. MCLX scheme seems
to follow this approach, but does not rely on the bootloader.

  Has anyone investigated this? Or anything already done,
  and cares to share it? Any thoughts on this?


Best regards,
-Arun.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
