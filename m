Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 12150B71BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2011 02:03:37 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: "smitha.vanga@wipro.com" <smitha.vanga@wipro.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: IRQ2 and IRQ 3
Date: Tue, 18 Oct 2011 15:03:27 +0000
Message-ID: <B8D6CA50DACE9E4AAADE9A4D56FBAAE623CED7@039-SN1MPN1-005.039d.mgd.msft.net>
References: <B8D6CA50DACE9E4AAADE9A4D56FBAAE623BEB3@039-SN1MPN1-005.039d.mgd.msft.net>
 <40631E9A2581F14BA60888C87A76A1FE016391@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE016391@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,=20

For detail please look at ePAPR specification.

Say i2c interrupt number is 21 then you can try
"interrupts =3D <21 8>;" in device tree.

Thanks
-Bharat

> -----Original Message-----
> From: smitha.vanga@wipro.com [mailto:smitha.vanga@wipro.com]
> Sent: Tuesday, October 18, 2011 2:35 PM
> To: Bhushan Bharat-R65777; Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: RE: IRQ2 and IRQ 3
>=20
> Yes , there is a vector numbe defined in the specifications .
>=20
> IRQ2 - 20
> IRQ3 - 21
>=20
> But I don't know how to specify them in the .dts file .
>=20
> Regards,
> Smitha
> Please do not print this email unless it is absolutely necessary.
>=20
> The information contained in this electronic message and any attachments
> to this message are intended for the exclusive use of the addressee(s)
> and may contain proprietary, confidential or privileged information. If
> you are not the intended recipient, you should not disseminate,
> distribute or copy this e-mail. Please notify the sender immediately and
> destroy all copies of this message and any attachments.
>=20
> WARNING: Computer viruses can be transmitted via email. The recipient
> should check this email and any attachments for the presence of viruses.
> The company accepts no liability for any damage caused by any virus
> transmitted by this email.
>=20
> www.wipro.com
