Return-Path: <R65777@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
 [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2C3DEB6F91
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2011 14:58:46 +1100 (EST)
Received: from mail16-db3 (localhost.localdomain [127.0.0.1])	by
 mail16-db3-R.bigfish.com (Postfix) with ESMTP id 8FDA7ED8145	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2011 03:58:39 +0000 (UTC)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: "smitha.vanga@wipro.com" <smitha.vanga@wipro.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: I2c-cpm driver not working
Date: Mon, 17 Oct 2011 03:58:26 +0000
Message-ID: <B8D6CA50DACE9E4AAADE9A4D56FBAAE62372F8@039-SN1MPN1-005.039d.mgd.msft.net>
References: <B8D6CA50DACE9E4AAADE9A4D56FBAAE622DD7D@039-SN1MPN1-004.039d.mgd.msft.net>
 <40631E9A2581F14BA60888C87A76A1FE015C1A@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE015C1A@HYD-MKD-MBX4.wipro.com>
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

Hi Smitha,

Can you provide the device tree information for i2c node?

Thanks
-Bharat

> -----Original Message-----
> From: smitha.vanga@wipro.com [mailto:smitha.vanga@wipro.com]
> Sent: Friday, October 14, 2011 3:33 PM
> To: Bhushan Bharat-R65777; Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: RE: I2c-cpm driver not working
>=20
>=20
>  Hi ,
>=20
>=20
> I see that the i2c_master_send works but when I do a i2c_master_recv
> returns with a error code -121.
>=20
> What should be the i2c-base address be configured for the i2c-cpm driver
> for mpc9247 . Also
>=20
> When I pass the interrupt for this driver as 1 , I see the registered
> interrupt number as 10 in /proc/interrupts why is it like this?
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
