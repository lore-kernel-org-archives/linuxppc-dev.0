Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1DB5B7043
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Oct 2009 10:25:51 +1100 (EST)
Date: Sun, 11 Oct 2009 00:13:24 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Kacur <jkacur@redhat.com>
Subject: Re: [patch 22/28] macintosh: Remove BKL from ans-lcd
Message-ID: <20091011001324.49e9733d@lxorguk.ukuu.org.uk>
In-Reply-To: <alpine.LFD.2.00.0910102309570.3669@localhost.localdomain>
References: <20091010153314.827301943@linutronix.de>
	<20091010153349.966159859@linutronix.de>
	<alpine.LFD.2.00.0910102309570.3669@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

> There were 4 checkpatch errors on this patch, all of the type
> ERROR: spaces required around that '=' (ctx:WxO)
> #1466: FILE: drivers/macintosh/ans-lcd.c:112:
> +			ret =-EACCES;

Here's a suggestion. If a few spaces bug you that much then instead of
complaining about it and posting checkpatch results deal with the file
itself. 

Wait until the patch goes in and send a follow up patch that fixes up the
file to fit codingstyle. There's no point whining about the bits a patch
touches when the file wasn't in that format before, but if you've got
nothing better to do then doing a pass over the whole file *is* useful.

(Plus it gets a patch to your name ;))

Checkpatch whines on files that simple don't follow style are usually
best ignored because they make the file formatting less internally
consistent.

Alan
