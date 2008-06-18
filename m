Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/9] powerpc: Add kernel support for POWER7 VSX. 
In-reply-to: <3DC08C70-5096-47BF-8452-367495F8B19E@kernel.crashing.org> 
References: <1213750053.678227.22239172650.qpush@coopers>
	<3DC08C70-5096-47BF-8452-367495F8B19E@kernel.crashing.org>
Date: Thu, 19 Jun 2008 09:54:18 +1000
Message-ID: <13421.1213833258@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Jun 17, 2008, at 7:47 PM, Michael Neuling wrote:
> 
> > The following set of patches adds Vector Scalar Extentions (VSX)
> > support for POWER7.  Includes context switch, ptrace and signals  
> > support.
> >
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > This series is on top of the POWER7 cputable entry patch.
> >
> > Paulus: please consider for your 2.6.27 tree.
> 
> I bit better explanation of what VSX would be useful.  Its not clear  
> to me exactly how these instructions behave such that we have to touch  
> all this code.

There is a register layout description which it looks like you found at
the top of patch 5.

Mikey
