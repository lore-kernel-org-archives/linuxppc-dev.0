Return-Path: <jkacur@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 76725B70B3
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Oct 2009 10:28:05 +1100 (EST)
Date: Sun, 11 Oct 2009 01:27:24 +0200 (CEST)
From: John Kacur <jkacur@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 22/28] macintosh: Remove BKL from ans-lcd
In-Reply-To: <20091011001324.49e9733d@lxorguk.ukuu.org.uk>
Message-ID: <alpine.LFD.2.00.0910110125000.4921@localhost.localdomain>
References: <20091010153314.827301943@linutronix.de>
	<20091010153349.966159859@linutronix.de>
	<alpine.LFD.2.00.0910102309570.3669@localhost.localdomain>
	<20091011001324.49e9733d@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Vincent Sanders <vince@simtec.co.uk>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sun, 11 Oct 2009, Alan Cox wrote:

> > There were 4 checkpatch errors on this patch, all of the type
> > ERROR: spaces required around that '=' (ctx:WxO)
> > #1466: FILE: drivers/macintosh/ans-lcd.c:112:
> > +			ret =-EACCES;
> 
> Here's a suggestion. If a few spaces bug you that much then instead of
> complaining about it and posting checkpatch results deal with the file
> itself. 
> 
> Wait until the patch goes in and send a follow up patch that fixes up the
> file to fit codingstyle. There's no point whining about the bits a patch
> touches when the file wasn't in that format before, but if you've got
> nothing better to do then doing a pass over the whole file *is* useful.
> 
> (Plus it gets a patch to your name ;))
> 
> Checkpatch whines on files that simple don't follow style are usually
> best ignored because they make the file formatting less internally
> consistent.
> 
Thanks Alan, I was sincerely debatting whether to send this because I know 
that checkpatch can be annoying - but on the other hand, I thought it 
prudent to run it since I was claiming to have reviewed all of those 
patches.

I like your suggestion though - next time, I won't send the mail, since 
since the folks submitting these patches are more than capable of checking 
that kind of thing themselves, and if I feel it's important enough, I'll 
follow up with a trivial style patch.

Cheers!

John
