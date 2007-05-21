Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ex01.ads.ubidyne.de (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id B25D0DDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 May 2007 17:25:28 +1000 (EST)
Subject: RE: BDI2000 configuration file for MPC8313E-RDB
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Mon, 21 May 2007 09:25:05 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E8491768E6@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: "Leonid" <Leonid@a-k-a.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Leonid asked:
> > And here most important question comes: for our actual HW we are
going=20
> > to use ST-Micro NAND flash, one of NAND512-B, NAND01G-B, NAND02G-B,=20
> > NAND04G-B and NAND08G-B. Is BDI2000 capable of programming these=20
> > flashes? What changes in .cfg file are required?

> Sorry, but the BDI does not support programming any NAND flash.
> You can write your own driver. Then load the data and the driver into=20
> SDRAM via the BDI and execute it.

Well, I think I have to try this, if there's really no other way.=20
I'm not quite sure, maybe you know the PowerTAB Pro JTAG Debugger,
(it's recommended in the manuals) could this one get directly access
to NAND memory?

> I'm afraid I didn't understand you. Are you saying that you actually
> were able to program NAND using BDI2000? I would like to know how you
> achieved that. I suspect that was some kind of "indirect" procedure,
> Ruedi wrote about, but please provide details.

Uhm, it's possible that achieved that in an "indirect" way that I was
not aware of. But as I said, the complete flash and ram was empty, just
loaded=20
the corresponding BDI config file to BDI2000 JTAG and I got access to
flash memory where I placed the bootloader image. Hmm, anyway ;)

The BDI config: http://www.ultsol.com/config/Emb%20Planet/83xx.cfg


Best regards

Frank
