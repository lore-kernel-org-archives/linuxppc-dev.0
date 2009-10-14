Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5255EB7B6F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 09:10:33 +1100 (EST)
In-Reply-To: <1255557130.2347.58.camel@pasglop>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091014172003.GD21215@loki.buserror.net>	
	<OF64D89B73.6073827F-ONC125764F.00687BC4-C125764F.0068D4DC@transmode.se>
	<4AD62516.6090301@freescale.com>	
	<OF22DCA2B2.1ADC3BC0-ONC125764F.006DE50F-C125764F.006E305A@transmode.se>
	<4AD63301.6090307@freescale.com>	
	<OF459A0F65.D3201748-ONC125764F.00738958-C125764F.00744CF0@transmode.se>
	<4AD63F48.8030301@freescale.com> <1255555029.2347.55.camel@pasglop>	
	<OFDAF14BF7.E3D4EBC9-ONC125764F.0076DF84-C125764F.00772817@transm
	<1255557130.2347.58.camel@pasglop>
Subject: Re: [PATCH 4/8] 8xx: Fixup DAR from buggy dcbX instructions.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF0FE78FDB.D4DF3BFA-ONC125764F.007997E0-C125764F.0079ACA0@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 15 Oct 2009 00:09:00 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 14/10/2009 23:52:10:
>
> On Wed, 2009-10-14 at 23:41 +0200, Joakim Tjernlund wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 14/10/2009 23:17:09:
> > >
> > > On Wed, 2009-10-14 at 16:14 -0500, Scott Wood wrote:
> > > >
> > > > I think the last working version was a little older than that -- and it's quite
> > > > possible that there was underlying badness even earlier that just recently got
> > > > exposed.  I think I want to just debug it and find out what's really going on.
> > >
> > > That would be good :-)
> > >
> > > I've been itching to do that but without HW it's not trivial :-)
> >
> > Meanwhile, how about the tlb asm you promised me? :)
> > It will be a challenge I think since you only have 2 GPRs
> > I guess it would be possible to stash yet another reg since it
> > will fit in the cache line already used by the TLB handlers.
>
> Let's just get it working first :-)

Chicken :):)
