Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id D2F86DDE44
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 18:16:46 +1100 (EST)
Date: Thu, 7 Feb 2008 01:16:20 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: asm-offsets.c
Message-ID: <20080207071620.GD14201@localdomain>
References: <47AA8C7D.3030109@pikatech.com> <20080207045129.GA4324@lst.de>
	<20080207064934.GC14201@localdomain>
	<20080207065540.GA9488@lst.de> <47AAACF9.9030901@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47AAACF9.9030901@pikatech.com>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan wrote:
> Christoph Hellwig wrote:
> > On Thu, Feb 07, 2008 at 12:49:34AM -0600, Nathan Lynch wrote:
> >   
> >> Christoph Hellwig wrote:
> >>     
> >>> On Wed, Feb 06, 2008 at 11:43:41PM -0500, Sean MacLennan wrote:
> >>>       
> >>>> I just did a git pull of Josh's tree, and 
> >>>> arch/powerpc/kernel/asm-offsets.c does not compile. I have only been 
> >>>> glossing over the linuxppc-dev emails, so forgive me if this already 
> >>>> came up.
> >>>>         
> >>> I have the same problem with current powerpc.git.
> >>>       
> >> What are the exact error and config?  I haven't been able to reproduce
> >> this with several defconfigs and toggling CONFIG_HIGH_RES_TIMERS.
> >>     
> Same error. I did a search for CLOCK_REALTIME_RES and it is not defined 
> in any *.[chS] file.

CLOCK_REALTIME_RES is defined in include/asm/asm-offsets.h, which is
generated from asm-offsets.c as part of the build.

Your config builds fine here, so please post the actual error that you
are seeing during the build?
