Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.kontron-modular.com
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id D98CA67B96
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 00:07:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: How to move from /ppc/ to /powerpc/
Date: Wed, 13 Sep 2006 16:07:16 +0200
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E24DD@kom-mailsrv1.kontron-modular.com>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
To: "Fredrik Roubert" <roubert@df.lth.se>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Fredrik,

our Kontron board is not identical to the SYS-Board, but has the same =
processor/chipset.
We are also not using U-Boot, but the Kontron NetBootloader, and our FDT =
implemtation does not use the dts. We have implemented this from scratch =
using the available documents regarding the required data to be passed.
For this reason, this will not be helpful for you.

Best regards,
Claus


-----Original Message-----
From: linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org=
]
On Behalf Of Fredrik Roubert
Sent: Mittwoch, 13. September 2006 15:30
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to move from /ppc/ to /powerpc/


On Wed 13 Sep 08:58 CEST 2006, Claus Gindhart wrote:

> i am running a Kontron board (which has the same SoC as the =
MPC834x_SYS
> onboard) with the Freescale version of the 2.6.17-Kernel, and its
> working well. Together with my update from 2.6.13 i migrated from
> arch/ppc to arch/powerpc.

Interesting! What dts file are you using?

Cheers // Fredrik Roubert

--=20
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/
