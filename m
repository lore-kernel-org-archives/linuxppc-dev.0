Return-Path: <R65777@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B1633B70C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 15:08:41 +1100 (EST)
Received: from mail88-am1 (localhost.localdomain [127.0.0.1])	by
 mail88-am1-R.bigfish.com (Postfix) with ESMTP id 9CAF74902AA	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 04:08:35 +0000 (UTC)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: "smitha.vanga@wipro.com" <smitha.vanga@wipro.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: I2c-cpm driver not working
Date: Tue, 18 Oct 2011 04:05:39 +0000
Message-ID: <B8D6CA50DACE9E4AAADE9A4D56FBAAE623B55D@039-SN1MPN1-005.039d.mgd.msft.net>
References: <B8D6CA50DACE9E4AAADE9A4D56FBAAE62372F8@039-SN1MPN1-005.039d.mgd.msft.net>
 <40631E9A2581F14BA60888C87A76A1FE015E0E@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE015E0E@HYD-MKD-MBX4.wipro.com>
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



> -----Original Message-----
> From: linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.or=
g
> [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> smitha.vanga@wipro.com
> Sent: Monday, October 17, 2011 1:48 PM
> To: Bhushan Bharat-R65777; Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: RE: I2c-cpm driver not working
>=20
>=20
> Hi Bhusan,
>=20
> Below is i2c node in the device tree.
>=20
> i2c@11860 {
> 				compatible =3D "fsl-i2c-cpm";
> 				device_type =3D "i2c";
> 	  			reg =3D <11860 20 8afc 2>;
> 				interrupts =3D <1 8>;
> 				interrupt-parent =3D <10c00>;
> 				#address-cells =3D <1>;
> 				#size-cells =3D <0>;
> 				cell-index =3D <0>;
> 				fsl,cpm-command =3D <29600000>;
>=20
>=20
> 			};
>=20

This looks ok to me, I hope you provides proper reg, interrupt number, pola=
rity and sense (as per you mpc9247 specification)?

Thanks
-Bharat

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
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
