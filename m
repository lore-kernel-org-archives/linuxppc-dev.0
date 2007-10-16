Return-Path: <SRS0=+eM0=PK=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 5D7DADDE9D
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 16:15:10 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: boards in arch/ppc -> arch/powerpc for 85xx
Date: Tue, 16 Oct 2007 08:15:38 +0200
References: <7DBC0977-0367-40F5-8A30-ACA02FD4E9FA@kernel.crashing.org>
	<200710160728.38897.sr@denx.de>
	<D332B7CF-6633-494C-8031-807F7DF53D78@kernel.crashing.org>
In-Reply-To: <D332B7CF-6633-494C-8031-807F7DF53D78@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710160815.38646.sr@denx.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 16 October 2007, Kumar Gala wrote:
> On Oct 16, 2007, at 12:28 AM, Stefan Roese wrote:
> > On Tuesday 16 October 2007, Kumar Gala wrote:
> >>>> I'm willing to look into doing the port over, but would need some
> >>>> help testing.
> >>>
> >>> Yes, it would be greatly appreciated if you could start this
> >>> TQM85xx port. I
> >>> will of course do the testing.
> >>
> >> Ok, for the TQM85xx code in arch/ppc can I get a few things from you:
> >>
> >> 1. what processors does this actually support/run on.  I'm guessing
> >> MPC8541, MPC8555?  But not really sure
> >
> > IIRC there are 4 different versions of the board:
> > - 8540, 8541, 8555 & 8560
>
> do they all boot/run with the code that exists in arch/ppc ?

Yes. I have to admit though, that I'm not sure if the denx arch/ppc version 
differs from the kernel.org version.

Best regards,
Stefan
