From: ckrobins@rockwellcollins.com
Subject: Trying to add SCSI hard disk as additional filesystem to Motorola MVME-3604
 that boots from ramdisk
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 16 Oct 2001 10:35:41 -0500
Message-ID: <OF46710E85.C37E1C35-ON86256AE7.00496232@collins.rockwell.com>
MIME-Version: 1.0
Content-type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am having difficulty with interfacing an 8-bit SCSI hard disk to an
embedded system that boots from a ramdisk.

The embedded system is VME-based and has a Motorola MVME-3604 SBC which
boots from a ramdisk.    The OS
is Yellow Dog Linux (version 2.2.12) with Gabriel Paubert's patches applied
for use with the MVME-2604.    My
predecessor did the job of getting this initial system up and running.
I have a fair amount of experience with Unix,
mostly Solaris boxes, and some experience with running Linux, but this is
the first I've had to do with patching and
building kernels.

So far, I have changed the configuration file ('make menuconfig') to add
SCSI support, AIC-7XXX, and ncr53c8xx &
sym53c8xx.    I modified the ramdisk's /etc/fstab file to add the line
'/dev/sda /mnt ext2 noauto 0 0'

The specific errors are:

1. modprobe: modprobe: Can't locate module block-major-8
2. /dev/sda isn't present in the table when I do a 'mount'

I also get a similar error from modprobe about   Can't locate module
char-major-4.

It appears to me that it's probably having trouble finding any modules at
all.
My predecessor's notes say (I think) that the module code is built into the
kernel we use, rather than loaded as
a module at runtime, so I guess that shouldn't be a surprise.    But what
should have been built into the kernel that
I missed?

I have a log file of the system as it boots, with all of the details.
It's about 10Kb large and it doesn't seem
appropriate to post, but I'll mail it to anyone whose interested.   Please
contact me at:  ckrobins@rockwellcollins.com

Thanks for your help and consideration

Regards,
Craig Robinson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
