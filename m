Message-ID: <D73A25AA6E54D511AD74009027B1110F3C04B3@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Donald MacArthur'" <dmacarth@ufl.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Embedded Planet RPX LICC_E board and Timesys
Date: Fri, 6 Dec 2002 09:13:52 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I built the Timesys Linux for the 850 and ran it on a LICC_E, it booted into
the initrd just fine.

-----Original Message-----
From: Donald MacArthur [mailto:dmacarth@ufl.edu]
Sent: Friday, December 06, 2002 7:25 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Embedded Planet RPX LICC_E board and Timesys



I am currently working on a research project involving
the RPX MPC850SR LICC_E board from Embedded Planet.

I tried the BSP provided by Timesys for the 850
but after tftping the image to the board and
'go' nothing happened.  I spoke to the reps from
timesys and embedded planet and found that the
850 BSP was compiled for the LITE_CW versions of the
Embedded Planet boards.  These differed due to the
existence of NVRAM and an RTC.

I recompiled the kernel using several different configurations
and was able to get the kernel to boot when the NVRAM option
was turned off.  I can boot the kernel and load the NFS
root with the initrd and ramdisk options turned off but
when I enable these options, the kernel stops booting at
the ramdisk creation.

Can anyone provide any insight about this problem?

Thank You
Donald MacArthur
dmacarth@ufl.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
