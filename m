Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D430DDE1A
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 04:50:15 +1000 (EST)
Message-ID: <46A103D9.6060200@freescale.com>
Date: Fri, 20 Jul 2007 13:50:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 04/14] spufs: add spu stats in sysfs and ctx stat file
	in spufs
References: <1184908885751-git-send-email-jk@ozlabs.org>	<11849088851210-git-send-email-jk@ozlabs.org>
	<20070720114421.0760cc5b.akpm@linux-foundation.org>
In-Reply-To: <20070720114421.0760cc5b.akpm@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> And what's up with all these powerpc people sending out patchbombs after
> the merge window has opened?  Formally, _all_ of this:

I can't speak for the ones you listed, but in my case, I had people 
asking about the patches and posting conflicting things, so I wanted to 
get it out for review.  I had no real expectation of it making it into 
2.6.23.

-Scott
