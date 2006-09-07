Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 5223267BA1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 21:20:24 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k87Cdcr1017423
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 06:39:38 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k87BKHjS006120
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 06:20:19 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8360E USB Host Controller Driver
Date: Thu, 7 Sep 2006 19:20:50 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D14C7B2@zch01exm20.fsl.freescale.net>
In-Reply-To: <DADA32856852FC458E0F96B664A6F55E011E2491@kom-mailsrv1.kontron-modular.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Claus Gindhart" <claus.gindhart@kontron.com>,
	"Alex Zeffertt" <ajz@cambridgebroadband.com>
Cc: n.balaji@gdatech.co.in, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> i have a MPC8347E running with the Freescale E(F)HCI driver=20
> and Kernel 2.6.17 (Freescale LTIB).
>=20
> Because of this mail, i checked, if there are any periodical=20
> interrupts, without real USB payload.
>=20
> The result is: NO
>=20
> If i attach a USB-mouse, i get 5 interrupts.
> If i remove it again, 1 additional.
>=20
> Nothing else, silence !
>=20
> USB works well with USB 1.1 and 2.0 devices (This was not the=20
> case with earlier Kernels, e.g. 2.6.13, because for the=20
> switching between 1.1 and 2.0 you need a transaction=20
> translator driver).

MPC834x USB is very different from the USB of CPM/QE.  It is an
integrated EHCI controller.

- Leo
