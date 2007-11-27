Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 981ACDDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 10:09:53 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 27 Nov 2007 16:09:51 -0700
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx software reset problems from paulus.git
Message-ID: <20071127230951.GA26687@xyzzy.farnsworth.org>
References: <473DB6DF.9010804@anagramm.de>
	<f87675ee0711161244h46c23d8byadaf1abb923b3971@mail.gmail.com>
	<f87675ee0711161328u3127de3bjdd6341cdf11cd626@mail.gmail.com>
	<0B4C1069-9D89-44E8-89F7-9E7CE07B03DF@kernel.crashing.org>
	<f87675ee0711161401k600b658ao3d6ae572fb367c47@mail.gmail.com>
	<7C2ED552-6644-4FB3-A97B-05FC3E2141FF@kernel.crashing.org>
	<f87675ee0711260941w25e5ed81v7322be1500fd5611@mail.gmail.com>
	<474B2A7F.5090607@anagramm.de>
	<20071127145424.8925.qmail@farnsworth.org>
	<751B3227-484E-45BE-B233-D4A8CAC2F3FD@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <751B3227-484E-45BE-B233-D4A8CAC2F3FD@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Nov 27, 2007 at 10:26:59AM -0600, Kumar Gala wrote:
> On Nov 27, 2007, at 8:54 AM, Dale Farnsworth wrote:
> >I wrote:
> >>Kumar Gala wrote:
> >>>>>Yes. The symptoms in 2.6.24RC2 are that during a kernel panic or  
> >>>>>when
> >>>>>calling 'reboot' in the shell, it just hangs. Using the same dts  
> >>>>>and
> >>>>>resets in 2.6.23.1 reboots fine. I don't have a cds reference, but
> >>>>>someone who does should be able to confirm whether the issue  
> >>>>>exists
> >>>>>or
> >>>>>not by just attempting to reboot via bash.
> >>>
> >>>Can someone do a git-bisect and find the patch that breaks things?
> >>
> >>I'll see if I can reproduce it on my 8548cds.  If so, I'll then git- 
> >>bisect.
> >
> >I tried this with the current powerpc.git tree on my mpc8548cds, and
> >the reboot command works for me.  The system rebooted just fine.
> 
> I'm wondering if there is an issue rebooting if we are in an oops.

I still can't reproduce it.  Current powerpc.git reboots OK after an
oops on my 8548cds.  As long as I make it to "Rebooting in 180 seconds..",
it resets 3 minutes later.  It may be hw-dependent as well as
sw-dependent.

-Dale
