Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20E87B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 08:03:19 +1100 (EST)
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20101018123750.ef7d6d48.akpm@linux-foundation.org>
References: <20101013144044.GS30667@csn.ul.ie>
	<20101013175205.21187.qmail@kosh.dhis.org>
	<20101018113331.GB30667@csn.ul.ie>
	<20101018123750.ef7d6d48.akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Oct 2010 08:02:16 +1100
Message-ID: <1287435736.2341.8.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org, pacman@kosh.dhis.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-18 at 12:37 -0700, Andrew Morton wrote:
> Well, you've spotted a bug so I'd say we fix it asap.
> 
> It's a bit of a shame that we lose the only known way of reproducing a
> different bug, but presumably that will come back and bite someone
> else
> one day, and we'll fix it then :(

Well, I can always revert that and run some experiments here, provided I
can reproduce the problem at all ...

Cheers,
Ben.
