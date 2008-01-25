Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2EC26DDE11
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:04:33 +1100 (EST)
Date: Fri, 25 Jan 2008 11:45:50 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 7/9] powerpc: add MPC837x RDB platform support
Message-Id: <20080125114550.661c3cf6.kim.phillips@freescale.com>
In-Reply-To: <ED723035-5E14-44B5-B35C-B94133561D78@kernel.crashing.org>
References: <20080124204711.02ba14f0.kim.phillips@freescale.com>
	<ED723035-5E14-44B5-B35C-B94133561D78@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jerry, Huang <Chang-Ming.Huang@freescale.com>,
	Joe D'Abbraccio <ljd015@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 Jan 2008 10:17:14 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Jan 24, 2008, at 8:47 PM, Kim Phillips wrote:
> 
> > primarily based on mpc837x mds code.
> >
> > Signed-off-by: Joe D'Abbraccio <ljd015@freescale.com>
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> > ---
> 
> Who's the actual other of these patches?  (all 9 of them).

I took Joe's 837x from:

http://ozlabs.org/pipermail/linuxppc-embedded/2007-September/028460.html

and updated them.

831x I took from Jerry Huang's tree and updated them.

Kim
