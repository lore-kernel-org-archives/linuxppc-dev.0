Return-Path: <baruch@tkos.co.il>
Received: from tango.tkos.co.il (tango.tkos.co.il [62.219.50.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8792FB6FD7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 15:03:27 +1000 (EST)
Date: Mon, 1 Aug 2011 08:02:51 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [RFC PATCH] powerpc: 85xx: Make e500/e500v2 depend on !E500MC
Message-ID: <20110801050251.GB5716@sapphire.tkos.co.il>
References: <fef1cfc9a418ec5aa3302915dcb392882f7dd5d2.1308545584.git.baruch@tkos.co.il>
	<CAOZdJXVsJUrCaNVHjhLkL=-GwAr79S9xQdoRLvjFG--k1jdRvw@mail.gmail.com>
	<4E31C04D.7040700@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E31C04D.7040700@freescale.com>
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Timur,

On Thu, Jul 28, 2011 at 03:02:21PM -0500, Timur Tabi wrote:
>  wrote:
> > On Sun, Jun 19, 2011 at 11:56 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> >> CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6, thus
> >> breaking clear_pages(), probably others too.
> >>
> >> Cc: Kumar Gala <galak@kernel.crashing.org>
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> ---
> >> Is this the right approach?
> > 
> > It doesn't work for me.
> 
> I also get this error if I try to build corenet32_smp_defconfig:
> 
> arch/powerpc/platforms/Kconfig.cputype:136:error: recursive dependency detected!
> arch/powerpc/platforms/Kconfig.cputype:136:	symbol PPC_E500MC is selected by
> P2040_RDB
> arch/powerpc/platforms/85xx/Kconfig:176:	symbol P2040_RDB depends on PPC_E500MC

Thanks for reporting. Where can I get this corenet32_smp_defconfig for 
testing?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
