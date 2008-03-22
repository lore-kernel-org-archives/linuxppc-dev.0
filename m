Return-Path: <jwboyer@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.237])
	by ozlabs.org (Postfix) with ESMTP id ACDAADDF2C
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 12:16:25 +1100 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so2012778qbe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 18:16:23 -0700 (PDT)
Date: Fri, 21 Mar 2008 20:14:42 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Add AMCC Glacier 460GT eval board dts
Message-ID: <20080321201442.71f657be@zod.rchland.ibm.com>
In-Reply-To: <9638a186ce2754343d4d349e55c15e2a@kernel.crashing.org>
References: <1205943310-26323-1-git-send-email-sr@denx.de>
	<1206090031.8420.67.camel@pasglop> <200803211154.34027.sr@denx.de>
	<20080321072419.2372774b@hansolo.jdub.homelinux.org>
	<9638a186ce2754343d4d349e55c15e2a@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Mar 2008 18:28:38 +0100
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> >>> As for the DTS, maybe a "compatible" property in the CPU might make 
> >>> some
> >>> sense with a content along the lines of "ppc440x6" or whatever rev of
> >>> the 440 core it is.
> >>>
> >>> What do you think ?
> >>
> >> Good idea. I'll try to come up with a list for all existing 4xx SoC's 
> >> and it's
> >> core versions.
> >
> > I don't really care either way, but what does that buy us?  Merely
> > documentation?
> 
> Obviously, as long as the kernel doesn't use the device tree for probing
> the CPUs available, additions to the device tree here don't affect the
> kernel at all ;-P

Yes, of course.  I meant were there other plans for it.  Ben and I had
a brief discussion of some of the possible uses and it seems pretty
sane.

josh
