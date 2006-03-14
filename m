Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 94DB567A39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Mar 2006 01:57:53 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Stable Linux kernel 2.6 for MPC8XX
Date: Tue, 14 Mar 2006 15:58:28 +0100
References: <20060310153341.080163525CB@atlas.denx.de>
	<200603140850.47014.david.jander@protonic.nl>
	<409257f58f9dab82d72ccd997516f772@embeddedalley.com>
In-Reply-To: <409257f58f9dab82d72ccd997516f772@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603141558.29155.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 14 March 2006 15:01, Dan Malek wrote:
> On Mar 14, 2006, at 2:50 AM, David Jander wrote:
> > I don't know why, but while everyone still says 2.6 is slower, I am
> > consistently getting results that seem to prove the opposite. Why?
>
> Because this is a compiler test and not an OS test.  The
> newer ELDK with 2.6 has better compilers.

No. Please read the cited e-mail entirely before jumping to such a conclusion.
I used the same ELDK for both kernels, and I didn't recompile the nbench 
binary ever again after the first time.

The reasons are different, still unknown and apparently my fault. See my 
previous post responding to WG.

Sorry to all for the confusion, looks like I must learn to be more careful 
when benchmarking.

To keep the answer short: nbench performs exactly the same on both kernels, as 
one would expect, since nbench doesn't stress the kernel. I was looking at 
incorrect results, trying to blame the cache/tlb management... I was just 
wrong, sorry.

Greetings,

-- 
David Jander
