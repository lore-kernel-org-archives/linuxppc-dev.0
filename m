Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 0DF022BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Oct 2004 06:53:57 +1000 (EST)
Date: Tue, 5 Oct 2004 13:53:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20041005205355.GM32692@smtp.west.cox.net>
References: <Pine.LNX.4.60.0410051228520.5107@dell.enoriver.com>
	<A337CA12-1703-11D9-B4FB-003065F9B7DC@embeddededge.com>
	<20041005192950.GL32692@smtp.west.cox.net>
	<Pine.LNX.4.60.0410051559560.3683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410051559560.3683@localhost.localdomain>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] first in a series to enhance microcode patches
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Oct 05, 2004 at 04:00:45PM -0400, Robert P. J. Day wrote:

> On Tue, 5 Oct 2004, Tom Rini wrote:
> 
> >On Tue, Oct 05, 2004 at 03:20:37PM -0400, Dan Malek wrote:
> 
> >>No, send a whole patch that _does_ something.  Let's see all of these
> >>changes at once.  By itself, this patch is useless and doesn't add any
> >>features, it just wastes our time discussing it.
> >
> >A series of inter-dependant patches might be better, but I like small,
> >easy to understand patches.
> 
> you know, it's a good thing i'm severely bipolar. :-)  somebody needs 
> to make a decision -- i'll go with whatever it is.

Ah.  I assumed you were sending out one chunk at a time something you
had 'done', sorry.  To be clear, what I prefer is a series of patches
that get something done.  A single small cleanup like you posted is
fine, but if you have it as part of a larger change, just include it in
the series.  'Documentation/SubmittingPatches' is probably a good
reference, subsituting linux-kernel with linuxppc-embedded :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
