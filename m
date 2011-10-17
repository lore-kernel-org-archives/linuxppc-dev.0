Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out02.wipro.com
 [203.91.198.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4987BB6F8C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2011 19:18:02 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <R65777@freescale.com>, <B07421@freescale.com>
Subject: RE: I2c-cpm driver not working
Date: Mon, 17 Oct 2011 08:17:49 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE015E0E@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <B8D6CA50DACE9E4AAADE9A4D56FBAAE62372F8@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Bhusan,

Below is i2c node in the device tree.

i2c@11860 {
				compatible =3D "fsl-i2c-cpm";
				device_type =3D "i2c";
	  			reg =3D <11860 20 8afc 2>;
				interrupts =3D <1 8>;
				interrupt-parent =3D <10c00>;
				#address-cells =3D <1>;
				#size-cells =3D <0>;
				cell-index =3D <0>;
				fsl,cpm-command =3D <29600000>;

				
			};


Regards,
Smitha
Please do not print this email unless it is absolutely necessary. 

The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. 

www.wipro.com
