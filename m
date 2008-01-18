Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 4A472DE017
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 22:07:11 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 82427F49119
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 12:07:07 +0100 (CET)
Subject: Re: [PATCH 2/2] mpc82xx: Embedded Planet EP8248E support
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080117223205.GB17300@loki.buserror.net>
References: <20080117223205.GB17300@loki.buserror.net>
Date: Fri, 18 Jan 2008 12:07:07 +0100
Message-Id: <1200654427.3204.4.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +			/* "Serial" port/SCC1 */
> +			scc1: serial@11a00 {
> +				device_type =3D "serial";
> +				compatible =3D "fsl,mpc8248-scc-uart",
> +				             "fsl,cpm2-scc-uart";
> +				reg =3D <0x11a00 0x20 0x8000 0x100>;
> +				interrupts =3D <40 8>;
are you sure with 40 as interrupt? has not it be "28"(hex) here?

> +				interrupt-parent =3D <&PIC>;
> +				fsl,cpm-brg =3D <1>;
> +				fsl,cpm-command =3D <0x00800000>;
> +				linux,planetcore-label =3D "SCC1";
> +			};

--=20
Dipl.-Ing. Sergej Stepanov=20
Software-Entwicklung

IDS GmbH=20
E-PA  (Entwicklung - Prozess Automatisierung)
Nobelstr. 18,=20
D-76275 Ettlingen=20
T. (0) 72 43/2 18-615=20
F. (0) 72 43/2 18-100=20
E. Sergej.Stepanov@ids.de

<http://www.ids.de>
Gesch=C3=A4ftsf=C3=BChrer: Norbert Wagner, Friedrich Abri=C3=9F=20
Sitz der Gesellschaft: Ettlingen=20
Amtsgericht Mannheim HRB 362503=20
