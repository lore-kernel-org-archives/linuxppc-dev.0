Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C7A3B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jul 2011 06:20:44 +1000 (EST)
Date: Thu, 28 Jul 2011 15:20:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [RFC PATCH] powerpc: 85xx: Make e500/e500v2 depend on !E500MC
Message-ID: <20110728152033.7f5b4c10@schlenkerla.am.freescale.net>
In-Reply-To: <CAOZdJXVsJUrCaNVHjhLkL=-GwAr79S9xQdoRLvjFG--k1jdRvw@mail.gmail.com>
References: <fef1cfc9a418ec5aa3302915dcb392882f7dd5d2.1308545584.git.baruch@tkos.co.il>
	<CAOZdJXVsJUrCaNVHjhLkL=-GwAr79S9xQdoRLvjFG--k1jdRvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Baruch Siach <baruch@tkos.co.il>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 28 Jul 2011 19:56:53 +0000
Tabi Timur-B04825 <B04825@freescale.com> wrote:

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
> 
> It might be necessary to split the entire menu into two parts, one for
> e500v2 parts and one for e500mc parts.
> 

How about making the "Processor Type" entry be either E500 or E500MC, both
of which select PPC_85xx?

-Scott
