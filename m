Message-ID: <38BF5C2A.9A6FCADD@ncal.verio.com>
Date: Thu, 02 Mar 2000 22:31:06 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Some small progress on PowerBook 2000 (Pismo - 102)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I've been able to get the LinuxPPC 2000 lite image to boot to a ramdisk
shell on
a PowerBook 2000. Used a USB keyboard and Bootx 1.2b3 with the 'redhat'
bootparm
to boot to the text-based installer. When the first installer window
appears it
does take input and a ^z goes to the ramdisk shell (continuing the
install fails
when trying to mount the CDROM).

One other factor that I need to confirm really makes a difference, is
that after
seeing kmsgs about unsupported frame buffer, I set the LCD depth down to
256 colors.
I need to retry and see if this really matters.

I have been able to mount an HFS partition to /mnt, just had to wait for
a
screenful of "hda: lost interrupt messages" to go by. I'm currently
attempting to
write the kmsgs to that partition (any secrets I need to know?). I'll
post it
if a file actually gets written, otherwise I'm willing to manually
transcribe and post interesting kmsg and /proc entries, let me know what
may be usefull. This weekend
I'll look into activating the eth0 interface to dump data.

Are there any bootparms that would be useful for reconfiguring the ide
i/f
to polled I/O or perhaps persuading the kernel to use the ADB keyboard
(it is
recognized in the boot messages)? Any alternate ram-disk images that may
be
more usefull for debugging?

BTW, booting from the LinuxPPC 2000 Lite cd image (Mar. 1 version) fails
with
a can't find yaboot.conf message.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
