Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6.jnb1.host-h.net [196.22.132.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0071DDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 01:09:21 +1100 (EST)
Message-ID: <49942D68.7080706@vastech.co.za>
Date: Thu, 12 Feb 2009 16:08:40 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [MPC8272ADS]Problem adding flash partitions inside the device tree
References: <8cad0aa0902120123p27cfe32fg6bf08d458178c937@mail.gmail.com>	
	<49940265.1020700@vastech.co.za>	
	<8cad0aa0902120310g44a3bf3cla4ffa94ea9bf5dc6@mail.gmail.com>	
	<20090212133037.GA3651@yookeroo.seuss>
	<8cad0aa0902120536p3303322cvf9a7307391d195b9@mail.gmail.com>
In-Reply-To: <8cad0aa0902120536p3303322cvf9a7307391d195b9@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms030401060606080905010802"
Cc: Jean-Michel Hautbois <jhautbois@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a cryptographically signed message in MIME format.

--------------ms030401060606080905010802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jean-Michel Hautbois wrote:
> 2009/2/12 David Gibson <david@gibson.dropbear.id.au
> <mailto:david@gibson.dropbear.id.au>>
>
>     On Thu, Feb 12, 2009 at 12:10:58PM +0100, Jean-Michel Hautbois wrote:
>     > 2009/2/12 Pieter <phenning@vastech.co.za
>     <mailto:phenning@vastech.co.za>>
>     >
>     > > Jean-Michel Hautbois wrote:
>     > > > Warning (reg_format): "reg" property in
>     > > > /localbus@f0010100/flash@0,0/partition@ff800000 has invalid
>     length (8
>     > > > JM
>     > > You are missing some definitions, The #address-cells and
>     #size-cells = <1>;
>     > > tis is a snippet of teh dts i defined for my board.
>     > >
>     > >        flash@0,0 {
>     > >            #address-cells = <1>;
>     > >            #size-cells = <1>;
>     > >            compatible = "cfi-flash";
>     > >            reg = <0x0 0x0 0x08000000>;
>     > >             bank-width = <4>;
>     > >            device-width = <1>;
>     > >
>     > >             /* set flash partition to correspond tu mtd parts in
>     > > u-boot*/
>     > >            /*     0xf8000000 */
>     > >            partition@0x0 {
>     > >                label = "factory-image";
>     > >                reg = <0x00000000 0x01000000>;
>     > >            };
>     > >            /*     0xf9000000 */
>     > >            partition@0x01000000 {
>     > >                label = "app-image-1";
>     > >                reg = <0x01000000 0x01000000>;
>     > >            };
>     > > cheers pieter
>     > >
>     >
>     > Hi do have these definitions, at a higher level:
>
>     The address-cells and size-cells definitions are not inherited.  They
>     cover only the immediate children of the node where they appear.
>     Otherwise the default values apply (address-cells == 2, size-cells ==
>     1), which are not right for your case.
>
>     --
>     David Gibson                    | I'll have my music baroque, and
>     my code
>     david AT gibson.dropbear.id.au <http://gibson.dropbear.id.au>  |
>     minimalist, thank you.  NOT _the_ _other_
>                                    | _way_ _around_!
>     http://www.ozlabs.org/~dgibson <http://www.ozlabs.org/%7Edgibson>
>
> OK, so, after having tested, I can't see any changes when booting.
> I do not have more mtd in /proc/mtd.
>
> JM
have you defined the following in your kernel  config

CONFIG_MTD_PHYSMAP_OF=y
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_OF_PARTS=y

cheers pieter


--------------ms030401060606080905010802
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
KdirPu7g6Ik1UAb2PbrW1wAAAAAAAA==
--------------ms030401060606080905010802--
