Return-Path: <baruch@tkos.co.il>
Received: from tango.tkos.co.il (tango.tkos.co.il [62.219.50.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58293B7150
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 14:43:48 +1000 (EST)
Date: Wed, 10 Aug 2011 07:43:07 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc: 85xx: separate e500 from e500mc
Message-ID: <20110810044307.GA2804@sapphire.tkos.co.il>
References: <1fb57aeaeefcc40f6646d026caba8d40371d18fb.1312175199.git.baruch@tkos.co.il>
	<029dda0b5fef124811bd4c577bdade25d7f93fba.1312794031.git.baruch@tkos.co.il>
	<4E403C3C.1050001@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E403C3C.1050001@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

On Mon, Aug 08, 2011 at 02:42:52PM -0500, Scott Wood wrote:
> On 08/08/2011 04:07 AM, Baruch Siach wrote:
> > CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6, thus
> > breaking clear_pages(), probably others too.
> > 
> > This patch adds a new "Processor Type" entry for e500mc, and makes e500 systems
> > depend on PPC_E500.
> 
> I can see confusion coming from having CONFIG_E500 and CONFIG_PPC_E500...

I agree.

> Maybe CONFIG_PPC_E500V1_2?  Or CONFIG_PPC_E500V2, with a note in the
> kconfig help that it supports e500v1 as well.

I'll go for CONFIG_PPC_E500_V1_V2. A revised patch is on the way.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
