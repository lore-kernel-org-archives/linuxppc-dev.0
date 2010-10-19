Return-Path: <helmut@subdivi.de>
Received: from linta.de (isilmar-3.linta.de [188.40.101.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CEBCCB70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Oct 2010 03:45:55 +1100 (EST)
Date: Tue, 19 Oct 2010 18:24:07 +0200
From: Helmut Grohne <helmut@subdivi.de>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
Message-ID: <20101019162407.GB10148@alf.mars>
References: <20101013144044.GS30667@csn.ul.ie>
	<20101013175205.21187.qmail@kosh.dhis.org>
	<20101018113331.GB30667@csn.ul.ie>
	<20101018123750.ef7d6d48.akpm@linux-foundation.org>
	<alpine.LFD.2.00.1010182342490.6815@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.00.1010182342490.6815@localhost6.localdomain6>
Cc: Mel Gorman <mel@csn.ul.ie>, LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, pacman@kosh.dhis.org,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 18, 2010 at 11:55:44PM +0200, Thomas Gleixner wrote:
> I might be completely one off as usual, but this thing reminds me of a
> bug I stared at yesterday night:

This problem is completely unrelated. My problem was caused by using
binutils-gold.

Helmut
