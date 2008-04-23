Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 83587DDF2A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 17:54:51 +1000 (EST)
Message-ID: <480EEB48.3080409@matrix-vision.de>
Date: Wed, 23 Apr 2008 09:54:48 +0200
From: =?ISO-8859-15?Q?Andr=E9_Schwarz?= <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: Question on MPC83xx interrupts
References: <480E1939.6000701@matrix-vision.de>	
	<20080422172306.GA17992@ld0162-tx32.am.freescale.net>
	<1208905031.6947.0.camel@concordia>
In-Reply-To: <1208905031.6947.0.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman schrieb:
> On Tue, 2008-04-22 at 12:23 -0500, Scott Wood wrote:
>> On Tue, Apr 22, 2008 at 06:58:33PM +0200, Andre Schwarz wrote:
>>> I wonder if the IRQ number should match the vector of the datasheet .=
..=20
>>> giving :
>> No.  The numbers in /proc/interrupts are virtual IRQ numbers, which ar=
e a
>> purely Linux-internal construct.
>=20
> You can see the mapping between virq and hwirq numbers by turning on
> CONFIG_VIRQ_DEBUG and looking in /sys/kernel/debug/powerpc/virq_mapping
> (after mounting debugfs).
>=20
> cheers
>=20

Ahhh - thanks Michael !

very useful ...



Cheers,
Andr=E9

MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
