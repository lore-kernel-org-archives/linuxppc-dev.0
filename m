Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO port
In-reply-to: <AANLkTinKbimKyLpvFD7KOvavshu_n8gRcp2BvEJj0XZQ@mail.gmail.com>
References: <20100308191005.GE4324@amak.tundra.com>
	<AANLkTine3pc2Ai2Woj81Y9fS_KgGs1sIMb2NMR6G74ww@mail.gmail.com>
	<AANLkTinKbimKyLpvFD7KOvavshu_n8gRcp2BvEJj0XZQ@mail.gmail.com>
Date: Tue, 03 Aug 2010 16:06:30 +1000
Message-ID: <4381.1280815590@neuling.org>
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

> > MCSR_MASK is not defined anywhere, so when I compile this code, I get this:
> 
> Never mind.  I see that it's been fixed already, and that the patch
> that removed MCSR_MASK was posted around the same time that this patch
> was posted.

I don't know what happened here but 2.6.35 is broken because of this
problem:

arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared (first use in this function)
arch/powerpc/sysdev/fsl_rio.c:248: error: (Each undeclared identifier is reported only once
arch/powerpc/sysdev/fsl_rio.c:248: error: for each function it appears in.)
arch/powerpc/sysdev/fsl_rio.c:250: error: 'MCSR_BUS_RBERR' undeclared (first use in this function)

Mikey
