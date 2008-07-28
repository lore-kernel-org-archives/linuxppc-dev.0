Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id C89FEDE102
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 02:40:00 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5875743wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 09:39:59 -0700 (PDT)
Date: Mon, 28 Jul 2008 10:39:56 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v3 0/4 REPOST] OF infrastructure for SPI devices
Message-ID: <20080728163956.GC21039@secretlab.ca>
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<200807271449.28472.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200807271449.28472.david-b@pacbell.net>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: spi-devel-general@lists.sourceforge.net, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 27, 2008 at 02:49:28PM -0700, David Brownell wrote:
> On Friday 25 July 2008, Grant Likely wrote:
> > I don't know what to do with these patches.  I'd really like to see them
> > in .27, and now that akpm has cleared his queue, the prerequisite patch
> > has been merged so they are ready to go in.  However, even though there
> > has been favourable reception on the SPI and linuxppc lists for these
> > changes I don't have any acks from anybody yet.
> > 
> > David, can you please reply on if you are okay with these patches
> > getting merged?  If so, do you want me to merge them via my tree, or
> > do you want to pick them up?
> 
> OK ... to recap, #1 and #3 are OF-specific, I'll be agnostic.
> If other OF folk think it's OK, great.
> 
> Some cleanup was needed for #2, but it was basically ok ...
> I'd like to see the final version, and if it goes via an
> OF push that's OK by me.  (Though I'd like to see that change
> make it into 2.6.27 regardless, so let me know.)

Thanks for the review.  1-3 is already merged into my git tree and Ben
has pulled them.  I hope that's okay.  Here's a link to the commit:

http://git.kernel.org/?p=linux/kernel/git/benh/powerpc.git;a=commitdiff;h=dc87c98e8f635a718f1abb2c3e15fc77c0001651

Let me know if you see anything else that needs to be changed and I'll
submit a fixup patch.

> And #4 isn't quite cooked yet.

Okay, I'll hack on this more and post v4.

Thanks again,
g.
