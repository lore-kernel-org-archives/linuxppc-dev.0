Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C70BDDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jul 2007 12:59:11 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l692x5Aj009484
	for <linuxppc-embedded@ozlabs.org>; Sun, 8 Jul 2007 19:59:05 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l692x3re004866
	for <linuxppc-embedded@ozlabs.org>; Sun, 8 Jul 2007 21:59:04 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: mpc83xx USB support status
Date: Mon, 9 Jul 2007 11:01:00 +0800
Message-ID: <989B956029373F45A0B8AF0297081890F05B32@zch01exm26.fsl.freescale.net>
In-Reply-To: <fa686aa40707061302o6ed9ec7cq2b9cdba2553cee7a@mail.gmail.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Tabi Timur-B04825" <timur@freescale.com>,
	"Behan Webster" <behanw@websterwood.com>,
	"Linux PPC Linux PPC" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant
> Likely
> Sent: Saturday, July 07, 2007 4:02 AM
> To: Li Yang-r58472; Tabi Timur-B04825; Behan Webster; Linux PPC Linux
PPC
> Subject: mpc83xx USB support status
>=20
> Li,
>=20
> What is the state of mpc83xx support in arch/powerpc?  I saw some of
> the patches you posted to the ppc and usb-devel lists, but I want to
> make sure I've got the whole set.  Also, can you tell me what the
> state of those patches are (ie. which ones will be picked up for
> 2.6.23?)

The USB host/gadget should be working in arch/powerpc with all the
patches I submitted to ppc and usb-devel applied.  AFAIK, all the
patches posted to usb-devel will be picked up for 2.6.23.  I hope the
platform rework code will also be picked up; I see nothing preventing it
from being included.

>=20
> I'm working on the mpc8349-mitx-gp board, and I can do the work to get
> your changes working on that board.

Good, the USB drivers are intended to be platform independent.  The soc
specific configuration will be done in the rework patch I submitted.
The only thing you need to take care of is board specific setup.  Feel
free to contact me if you have any problem.

- Leo
