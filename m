Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69EC3DDE19
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 09:58:06 +1100 (EST)
Date: Fri, 22 Feb 2008 01:57:28 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/1] [PPC] 8xx swap bug-fix
Message-ID: <20080222015728.31516db3@kernel.crashing.org>
In-Reply-To: <20080221122158.11BB324D16@gemini.denx.de>
References: <20080205013857.47ebe544@kernel.crashing.org>
	<20080221122158.11BB324D16@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dzu@denx.de, linuxppc-dev@ozlabs.org, Mackerras <paulus@samba.org>,
	Paul@ozlabs.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 21 Feb 2008 13:21:58 +0100
Wolfgang Denk wrote:

> Dear Vitaly,
> 
> in message <20080205013857.47ebe544@kernel.crashing.org> you wrote:
> > On Mon, 4 Feb 2008 12:24:21 -0600
> > Scott Wood wrote:
> > 
> > > On Sat, Feb 02, 2008 at 12:22:17PM +0100, Jochen Friedrich wrote:
> > > > Hi Yuri,
> > > > 
> > > > >  Here is the patch which makes Linux-2.6 swap routines operate
> > > > > correctly on the ppc-8xx-based machines.
> > > > 
> > > > is there any 8xx board left which isn't ported to ARCH=powerpc?
> > > 
> > > More importantly, is this something that is also broken in
> > > arch/powerpc?  It looks like it has the same code...
> > > 
> > yes, it is. Though there is currently no best-at-all solution, this
> > looks worth trying. I'll have a look how the 8xx feels under load
> > and report back.
> 
> Have you been able to check if arch/powerpc needs similar fixing?
> 
> 
> Also, what is the current state of this patch? I would like to avoid
> that it get's lost completeley.
> 
I have revalidated it (version modded to fit powerpc) with pretty tight stressing and can conclude
this is good enough for mainline (it gets things much better than they are now, 
in  case of swap enabled).

I'll follow-up with relevant patch shortly.



> 
> BenH commented on Tue, 05 Feb 2008 18:37:07 +1100:
> 
> > Best is to just remove writeback completely and let the generic
> > code handle it.
> 
> Has this been considered / tested by anybody?
> 
> Best regards,
> 
> Wolfgang Denk
> 


-- 
Sincerely, Vitaly
