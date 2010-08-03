Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2DF311007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Aug 2010 22:26:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO port
Date: Tue, 3 Aug 2010 05:17:54 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520114309D@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4381.1280815590@neuling.org>
References: <20100308191005.GE4324@amak.tundra.com>
	<AANLkTine3pc2Ai2Woj81Y9fS_KgGs1sIMb2NMR6G74ww@mail.gmail.com>
	<AANLkTinKbimKyLpvFD7KOvavshu_n8gRcp2BvEJj0XZQ@mail.gmail.com>
	<4381.1280815590@neuling.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Michael Neuling" <mikey@neuling.org>, "Timur Tabi" <timur.tabi@gmail.com>
Cc: Alexandre Bounine <abounine@tundra.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, thomas.moll@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This happened after change to book-e definitions.
There are patches that address this issue.

> -----Original Message-----
> From: Michael Neuling [mailto:mikey@neuling.org]
> Sent: Tuesday, August 03, 2010 2:07 AM
> To: Timur Tabi
> Cc: Alexandre Bounine; linuxppc-dev@lists.ozlabs.org;
linux-kernel@vger.kernel.org;
> thomas.moll@sysgo.com
> Subject: Re: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO
port
>=20
> > > MCSR_MASK is not defined anywhere, so when I compile this code, I
get this:
> >
> > Never mind.  I see that it's been fixed already, and that the patch
> > that removed MCSR_MASK was posted around the same time that this
patch
> > was posted.
>=20
> I don't know what happened here but 2.6.35 is broken because of this
> problem:
>=20
> arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared
(first use in this function)
> arch/powerpc/sysdev/fsl_rio.c:248: error: (Each undeclared identifier
is reported only once
> arch/powerpc/sysdev/fsl_rio.c:248: error: for each function it appears
in.)
> arch/powerpc/sysdev/fsl_rio.c:250: error: 'MCSR_BUS_RBERR' undeclared
(first use in this function)
>=20
> Mikey
