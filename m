Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
 [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E3C57B70FE
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2011 03:42:47 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 1/2] powerpc/85xx: create dts components to build
 up an SoC
Date: Thu, 20 Oct 2011 16:42:39 +0000
Message-ID: <CAOZdJXWtnBB5=DahG8LGQpeP7or0VZv78duhtPiORk3WOir8gQ@mail.gmail.com>
References: <1319095467-6229-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1319095467-6229-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ok, your other patch makes more sense now.

On Thu, Oct 20, 2011 at 2:24 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:

> +++ b/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
> @@ -0,0 +1,8 @@
> +&serial0 {
> + =A0 =A0 =A0 cell-index =3D <0>;
> + =A0 =A0 =A0 device_type =3D "serial";
> + =A0 =A0 =A0 compatible =3D "ns16550";
> + =A0 =A0 =A0 reg =3D <0x4500 0x100>;
> + =A0 =A0 =A0 clock-frequency =3D <0>;
> + =A0 =A0 =A0 interrupts =3D <42 2 0 0>;
> +};

How about we put all serial devices into one pq3-duart.dtsi file, and
let the parent dtsi file reference just the ones that it needs?

--=20
Timur Tabi
Linux kernel developer at Freescale=
