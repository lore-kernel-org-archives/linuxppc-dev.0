Return-Path: <jsteve17@yahoo.com>
Received: from web33013.mail.mud.yahoo.com (web33013.mail.mud.yahoo.com
	[68.142.206.77]) by ozlabs.org (Postfix) with SMTP id 439686823D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Sep 2005 22:24:28 +1000 (EST)
Message-ID: <20050913121748.66647.qmail@web33013.mail.mud.yahoo.com>
Date: Tue, 13 Sep 2005 05:17:48 -0700 (PDT)
From: Jeff Stevens <jsteve17@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: USB root filesytem using a 2.6 kernel?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Has anyone had any luck booting from a linux filesytem
on a USB pen drive running 2.6?  I am running kernel
2.6.9 that is programmed into flash and am trying to
boot from a root filesystem on a USB pen drive.  I am
using the kernel command line option "root=/dev/sda1".
 I am able to NFS boot my system, and then mount my
pen drive, and can see all of the files fine. 
However, it tells me that I have an invalid root
option if I try setting root to /dev/sda1.  I
understand under 2.4 there is a patch that keeps
trying to mount the sda1 device with time delays in
between each try.  I tried that, but it didn't help. 
I also tried the 2.6 patch that keeps a list of ready
devices, and that didn't work.  I was trying to do
this without a ramdisk, but so far it looks like I'll
have to use one after all.

Thanks,
   Jeff Stevens
   jsteve17@yahoo.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
