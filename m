Return-Path: <susheel_nuguru@yahoo.co.in>
Received: from web8502.mail.in.yahoo.com (web8502.mail.in.yahoo.com
	[202.43.219.164]) by ozlabs.org (Postfix) with SMTP id 255D867C5A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 18:48:41 +1000 (EST)
Message-ID: <20050719084838.3909.qmail@web8502.mail.in.yahoo.com>
Date: Tue, 19 Jul 2005 01:48:38 -0700 (PDT)
From: Susheel Raj <susheel_nuguru@yahoo.co.in>
To: david.wolfe@freescale.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: boot failure help needed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> If you're using rev.B1 silicon (mask M08A), you'll
need 
> to set the as of yet undocumented TXW_MASK bit (13
in 
> PPC bit ordering) in the Rx FIFO control register 
> (MBAR + 0x318c). Thus, set &fec->rfifo_cntrl to
> 0x0f040000 in mpc5xxx_fec_setup().

yes David i am using rev.B1 and I tried setting the
TXW_MASK bit but nothing changed ...

> If you're still having problems with Ethernet, I
would 
> suggest debugging it with a root file system on 
> something other than NFS.E.g. ramdisk, MTD or ATA.

I tried also ur second suggestion trying to boot
through ramdisk, with rootfilesystem in
ramdisk.image.gz and building kernel in pImage both in
Compact Flash.

It is working fine ( I have no idea of the
configuration and what args are passed by U_BOOt to
kernel) .. does this mean that there is problem with
root filesystem on my remote computer or does this
mean there could be a problem connecting to the remote
computer (Probably problem with BESTCOM as pointed by
Wolfgang Denk) ?????

I want to have the root filesystem on the remote
computer instead on ramdisk because i need to add
applications into the root filesystem in runtime.




		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
