Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158D55@norcom2.norcom.net>
From: Lokesh Kumar <lokesh.kumar@wrx-us.com>
To: "'Brian Padalino'" <bpadalino@perigee.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: U-Boot and 2.6.0-test1 kernel
Date: Thu, 24 Jul 2003 09:09:52 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


See u-boot's readme file. It describes the image format required for u-boot,
basically built from vmlinux using "mkimage" tool from denx eldk.

Lokesh

-----Original Message-----
From: Brian Padalino [mailto:bpadalino@perigee.com]
Sent: Thursday, July 24, 2003 8:35 AM
To: Linuxppc-Embedded
Subject: U-Boot and 2.6.0-test1 kernel



I just made and flashed U-Boot over the OpenBIOS on my Ebony board, and it
appears to be working very well.  I was able to do a tftp transfer and I
like the interface much better than the IBM OpenBIOS -- my only problem is
that when I download a binary image file made from the 2.6.0-test1 kernel,
it says something about a Bad Magic number if i do "imi" for "imageinfo".

Is there another utility I should be using to package this kernel up for
U-Boot, or am I just not choosing the right file?

Thanks,
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
