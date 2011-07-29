Return-Path: <baruch@tkos.co.il>
Received: from tango.tkos.co.il (tango.tkos.co.il [62.219.50.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C8F7B6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jul 2011 17:24:06 +1000 (EST)
Date: Fri, 29 Jul 2011 10:23:36 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [RFC PATCH] powerpc: 85xx: Make e500/e500v2 depend on !E500MC
Message-ID: <20110729072336.GC24030@tarshish>
References: <fef1cfc9a418ec5aa3302915dcb392882f7dd5d2.1308545584.git.baruch@tkos.co.il>
	<CAOZdJXVsJUrCaNVHjhLkL=-GwAr79S9xQdoRLvjFG--k1jdRvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOZdJXVsJUrCaNVHjhLkL=-GwAr79S9xQdoRLvjFG--k1jdRvw@mail.gmail.com>
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tabi,

On Thu, Jul 28, 2011 at 07:56:53PM +0000, Tabi Timur-B04825 wrote:
> On Sun, Jun 19, 2011 at 11:56 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> > CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6, thus
> > breaking clear_pages(), probably others too.
> >
> > Cc: Kumar Gala <galak@kernel.crashing.org>
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> > Is this the right approach?
> 
> It doesn't work for me.
> 
> I need something that if an e500v2 platform (e.g. the P1022DS) is
> selected, then I won't be able to select any e500mc platforms (e.g.
> P4080DS).  And if I don't select any e500v2 platforms, then I will be
> able to select an e500mc platform.  This patch doesn't seem to do
> that.

The source of the trouble seems to be the user selectable CONFIG_PPC_E500MC 
with the misleading "e500mc Support" description. I'll try to post something 
better next week.

> It might be necessary to split the entire menu into two parts, one for
> e500v2 parts and one for e500mc parts.

baurch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
