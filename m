Return-Path: <R65777@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 49023B70B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 19:58:17 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: "smitha.vanga@wipro.com" <smitha.vanga@wipro.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: IRQ2 and IRQ 3
Date: Tue, 18 Oct 2011 08:58:07 +0000
Message-ID: <B8D6CA50DACE9E4AAADE9A4D56FBAAE623BEB3@039-SN1MPN1-005.039d.mgd.msft.net>
References: <40631E9A2581F14BA60888C87A76A1FE01637C@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE01637C@HYD-MKD-MBX4.wipro.com>
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

Hi,

Is not some interrupt vector number defined for i2c in your soc specificati=
on(IIRC mpc9247 and I do not have this).

Thanks
-Bharat


> -----Original Message-----
> From: smitha.vanga@wipro.com [mailto:smitha.vanga@wipro.com]
> Sent: Tuesday, October 18, 2011 1:36 PM
> To: Wood Scott-B07421; Bhushan Bharat-R65777
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: RE: IRQ2 and IRQ 3
>=20
>=20
>=20
> Hi ,
>=20
> I want to use IRQ2 and IRQ3 in my driver. How do I add them in the device
> tree file.
>=20
> Regard,
> Smitha
>=20
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
