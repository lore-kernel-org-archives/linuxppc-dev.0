Return-Path: <chris@alcor.co.uk>
Received: from mizar.alcor-electronics.co.uk (alcor.demon.co.uk [62.49.62.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7FD412BF13
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 23:43:47 +1100 (EST)
From: "Chris Down" <chris@alcor.co.uk>
To: <wd@denx.de>
Date: Fri, 19 Nov 2004 12:43:33 -0000
Message-ID: <000001c4ce35$6194b260$0101a8c0@alcor1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <000601c4c9c5$514b34c0$0101a8c0@alcor1>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Problem bringing up Linux on Custom MPC852 Board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

.
> > > At this point it stops executing in arch_kernel_thread.
> >=20
> > I bet some beer that this is actually a FAQ - see
> > http://www.denx.de/twiki/bin/view/DULG/LinuxCrashesRandomly
> >=20
> > This phenomenon is typical for a novice's port of U-Boot.
> >=20
>=20
> Wolfgang, thanks for your reply. I will re-check the SDRAM=20
> initialisation and UPM programming.
>=20

Wolfgang,
The solution was a lot simpler, there was no problem with the SDRAM
initialisation. The cause was due to the fact that I had a BDI2000 =
connected and
the SYSIE bit was enabled in the DER for flash programming. Clearing =
this bit
solved the problem, probably a typical novice error :-)

Regards

Chris Down
