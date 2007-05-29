Return-Path: <LeoLi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: USB Host at full speed
Date: Tue, 29 May 2007 19:01:32 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D2A07A@zch01exm26.fsl.freescale.net>
In-Reply-To: <662798.70353.qm@web26515.mail.ukl.yahoo.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <axelnico@yahoo.fr>, <Linuxppc-embedded@ozlabs.org>
Cc: linux-usb-devel@lists.sourceforge.net
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
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf Of
> axelnico@yahoo.fr
> Sent: Tuesday, May 29, 2007 5:11 PM
> To: Linuxppc-embedded@ozlabs.org
> Subject: USB Host at full speed
>=20
> Hello ALL,
>=20
> I m currently trying to force the USB host controller from MPC8349 to
only work
> at full speed i.e. whatever is the connected device, the bandwidth
should be 12MB.
> I thought i could perform it just by setting some registers to right
value but it
> aren't working.
> I fear i have to force software to always use TT and split transfer
but i dont
> know exactly where to start..
>=20
> If anybody could help, would be so great!!

Your question can be interpreted as how to force EHCI host driver to
work in full speed.  Usb-devel list cc'ed should be a better place for
such a question.

- Leo
