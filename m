Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 15905681BE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Nov 2005 03:57:40 +1100 (EST)
Received: from mail01.m-online.net (unknown [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id D61207028D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 17:55:48 +0100 (CET)
Received: from embluxa7e0291e (213-163-18-7.vnet.hu [213.163.18.7])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 6DCEAB80EE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 17:57:38 +0100 (CET)
From: "Heiko Schocher" <hs@denx.de>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 21 Nov 2005 17:57:24 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNCELNCDAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: anyone used i2c-algo-8260 for the MPC8272 family?
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ron,

> There are some subtle differences b/t the 8260 family and 8272 family.
> The 8272 family only has 8KB DPRAM (c.f. 16KB), so I believe the
> definition of PROFF_I2C in include/linux/cpm_8260.h should be
> different.  I've changed it from:
> 
> 	#define PROFF_I2C	((16 * 1024) - 64)
> to 
> 	#define PROFF_I2C	((8 * 1024) - 64)
> 
> but still get no I2C activity, and a kernel hang.

I think your change above is right for a MPC8247.

> Anyone have this working, or any thoughts to contribute?

Look at my Patch, which I just posted at linuxppc-dev, which 
(I hope) will help you (!! it is for a MPC8260 based Board):

http://ozlabs.org/pipermail/linuxppc-dev/2005-November/020492.html

or have a look at the Git repository at Denx:

http://source.denx.net/git/linux-2.6-denx.git

where you can find the complete PM82x port for the 2.6.14 Kernel.

Best regards,
Heiko
