Return-Path: <torvalds@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0904FB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 02:53:56 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C811DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 02:53:55 +1000 (EST)
Date: Tue, 15 Sep 2009 09:53:08 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git next branch
In-Reply-To: <1252999835.8375.205.camel@pasglop>
Message-ID: <alpine.LFD.2.01.0909150943580.4950@localhost.localdomain>
References: <1252653473.8566.98.camel@pasglop>
	<1252999835.8375.205.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	FUJITA Tomonori <tomof@acm.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tue, 15 Sep 2009, Benjamin Herrenschmidt wrote:
> 
> So I don't know at this stage how to generate a "clean" pull request ...

It's rare, for but future reference, what you can do is to just do a 
merge in a temporary branch, and get it that way.

'git shortlog' should have worked, though. It's only the 'diff' that is 
based on the direct difference between two end-points, rather than based 
on working with intersections of sets of commits.

Maybe the scripts use 'origin...master' or something for the shortlog, and 
then the merge-base thing will confuse it? Haven't looked.

> In any case, the tree is still there waiting for you to pull. It seems
> to merge cleanly tonight though I haven't yet got a chance to test the
> result much.

It got a conflict with the AGP merge, but I fixed it up in what _seemed_ 
to be the obvious manner. But somebody should check out the resulting
drivers/char/agp/uninorth-agp.c file.

		Linus
