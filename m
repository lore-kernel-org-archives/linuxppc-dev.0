Return-Path: <Schramel.Linux@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id 465C467A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 22:33:38 +1000 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@ozlabs.org>
Date: Thu, 21 Apr 2005 15:02:48 +0200
References: <20050421103234.ED367C1510@atlas.denx.de>
In-Reply-To: <20050421103234.ED367C1510@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504211502.48761.Schramel.Linux@go.bartec.de>
Subject: Re: mtd mount problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

> > 
> > /dev # date > /dev/mtd1
> > MTD_open
> > MTD_ioctl
> > MTD_write
> > MTD do_write_buffer(): software timeout
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ERROR ERROR ERROR ERROR ERROR ERROR ERROR

This only occurs if i write the second time to the flash memory without erasing it before.

> What has a ramdisk to do with this?

I wrote in a message later, that i meant the /dev nodes in this case. 

> What does "cat /proc/mtd" show? What are  the  kernel  boot  messages
> look like?
> 
mtd0: 01000000 00020000 "JFFS2 partition 1"
mtd1: 00800000 00020000 "JFFS2 partition 2"
mtd2: 00400000 00020000 "RAMDISK "
mtd3: 00300000 00020000 "kernel image 2_4"
mtd4: 00100000 00020000 "Das U-Boot "

Best regards
Marco
