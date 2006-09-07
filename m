Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.e2brain.de [62.159.155.200])
	by ozlabs.org (Postfix) with ESMTP id 2B9EB67B82
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 21:12:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: MPC8360E USB Host Controller Driver
Date: Thu, 7 Sep 2006 13:12:05 +0200
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E2491@kom-mailsrv1.kontron-modular.com>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>,
	"Li Yang-r58472" <LeoLi@freescale.com>
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

Hi all,

i have a MPC8347E running with the Freescale E(F)HCI driver and Kernel =
2.6.17 (Freescale LTIB).

Because of this mail, i checked, if there are any periodical interrupts, =
without real USB payload.

The result is: NO

If i attach a USB-mouse, i get 5 interrupts.
If i remove it again, 1 additional.

Nothing else, silence !

USB works well with USB 1.1 and 2.0 devices=20
(This was not the case with earlier Kernels, e.g. 2.6.13, because for =
the switching between 1.1 and 2.0 you need a transaction translator =
driver).

--=20
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com

-----BEGIN GEEK CODE BLOCK-----
  Version: 3.1
  GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
  K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
  D-- G e++> h--- !r x+++
------END GEEK CODE BLOCK------
=20



-----Original Message-----
From: linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org=
]
On Behalf Of Alex Zeffertt
Sent: Donnerstag, 7. September 2006 12:59
To: Li Yang-r58472
Cc: n.balaji@gdatech.co.in; linuxppc-embedded@ozlabs.org
Subject: Re: MPC8360E USB Host Controller Driver


>> manual, they told that this controller does not belong to=20
>> UHCI or OHCI standard.
>=20
> Yes, you can call it FHCI if you like. :)

I heard that on the PQII (82xx) devices the FHCI required
intervention from the core, even when there was zero traffic
on the USB.  I think this was because the core had to
continuously service a 1ms interrupt.  This generates significant
extra loading, making it worth considering using a cheap EHCI chip
instead....

Does anyone know if this is still the case with the PQII Pro (83xx)?

Alex
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
