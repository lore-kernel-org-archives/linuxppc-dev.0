Message-ID: <9DCCE20055ACD311BBE200104B08D834012749B1@EXCHWENZ01>
From: Rod Boyce <rod_boyce@DMCWave.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: sorry!Another question about flash!
Date: Fri, 7 Sep 2001 08:16:45 +1200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't suppose you have though of writing your own flash driver for your
custom hardware and I did this the other day there is nothing to it.  I now
have Intel Strata flash working in Linux 2.2.14 kernel using block mode
writes very fast if it helps I could send it to you but the block write bit
is for our custom hardware so it may not work for you.

Rod

	-----Original Message-----
	From:	Kári Davíesson [mailto:kd@flaga.is]
	Sent:	Thursday, 6 September 2001 22:25
	To:	weiwu; linuxppc-embedded@lists.linuxppc.org
	Subject:	RE: sorry!Another question about flash!


	> -----Original Message-----
	> From: weiwu [mailto:weiwu@isdn.iscas.ac.cn]
	> Sent: 6. september 2001 10:18
	> To: linuxppc-embedded@lists.linuxppc.org
	> Subject: sorry!Another question about flash!
	>
	>
	>
	> >  A character device driver is included with our sources,
	> see for instance
	>
>ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-07-23.tar.bz2
	> >
	> >The standard solution is to use MTD, which is part of recent
	> kernels, too.
	>
	> 1.who have block device driver of flash?  And can I share with
you?
	>  (Intel 28F320J5(4MBytes, 8bit) flash memory)

	Check the mtd code. It allready supports 28F320 (16 bit 4Mb).

	>
	> 2.The "ftl or mtd" is only for PCMCIA?

	No. Check the mtd code. It can work with PCMCIA and ftl but they are
not
	necessary.

	> Can we use it in the general flash board ?such as ppc mother
board!

	I am using the mtd for 28F320 for a homegrown board, no pcmcia, no
ftl.
	Check the FLAGADM configuration in mtd.

	K.D.

	>
	>
	> I need help!Thank you very much!
	>
	>


	** Sent via the linuxppc-embedded mail list. See
http://lists.linuxppc.org/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
