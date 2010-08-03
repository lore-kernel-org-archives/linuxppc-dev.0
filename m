Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5C917B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Aug 2010 23:25:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO port
Date: Tue, 3 Aug 2010 06:24:47 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011430BC@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTinpwYnyc1oN1VbtBgUF6bk6E5q_Gq1Dj3WXV3wc@mail.gmail.com>
References: <20100308191005.GE4324@amak.tundra.com>
	<AANLkTine3pc2Ai2Woj81Y9fS_KgGs1sIMb2NMR6G74ww@mail.gmail.com>
	<AANLkTinKbimKyLpvFD7KOvavshu_n8gRcp2BvEJj0XZQ@mail.gmail.com>
	<4381.1280815590@neuling.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520114309D@CORPEXCH1.na.ads.idt.com>
	<AANLkTinpwYnyc1oN1VbtBgUF6bk6E5q_Gq1Dj3WXV3wc@mail.gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Timur Tabi" <timur@freescale.com>
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
	Alexandre Bounine <abounine@tundra.com>, thomas.moll@sysgo.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yang Li pointed to these patches in his post from July 23, 2010.
It would be nice to have these patches in mainline code.=20

> -----Original Message-----
> From: timur.tabi@gmail.com [mailto:timur.tabi@gmail.com] On Behalf Of
Timur Tabi
> Sent: Tuesday, August 03, 2010 9:02 AM
> To: Bounine, Alexandre
> Cc: Michael Neuling; Alexandre Bounine; linuxppc-dev@lists.ozlabs.org;
linux-kernel@vger.kernel.org;
> thomas.moll@sysgo.com; Kumar Gala
> Subject: Re: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO
port
>=20
> On Tue, Aug 3, 2010 at 7:17 AM, Bounine, Alexandre
> <Alexandre.Bounine@idt.com> wrote:
> > This happened after change to book-e definitions.
> > There are patches that address this issue.
>=20
> And those patches should have been applied before 2.6.35 was released.
>  Someone dropped the ball.  2.6.35 is broken for a number of PowerPC
> boards:
>=20
> $ make mpc85xx_defconfig
> ....
> $ make
> ....
>   CC      arch/powerpc/sysdev/fsl_rio.o
> arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_mcheck_exception':
> arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared
> (first use in this function)
> arch/powerpc/sysdev/fsl_rio.c:248: error: (Each undeclared identifier
> is reported only once
> arch/powerpc/sysdev/fsl_rio.c:248: error: for each function it appears
in.)
> make[1]: *** [arch/powerpc/sysdev/fsl_rio.o] Error 1
>=20
> --
> Timur Tabi
> Linux kernel developer at Freescale
