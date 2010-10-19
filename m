Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F3E4B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Oct 2010 03:42:48 +1100 (EST)
Date: Tue, 19 Oct 2010 18:42:09 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Helmut Grohne <helmut@subdivi.de>
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
In-Reply-To: <20101019162407.GB10148@alf.mars>
Message-ID: <alpine.LFD.2.00.1010191841430.6815@localhost6.localdomain6>
References: <20101013144044.GS30667@csn.ul.ie>
	<20101013175205.21187.qmail@kosh.dhis.org>
	<20101018113331.GB30667@csn.ul.ie>
	<20101018123750.ef7d6d48.akpm@linux-foundation.org>
	<alpine.LFD.2.00.1010182342490.6815@localhost6.localdomain6>
	<20101019162407.GB10148@alf.mars>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 19 Oct 2010, Helmut Grohne wrote:

> On Mon, Oct 18, 2010 at 11:55:44PM +0200, Thomas Gleixner wrote:
> > I might be completely one off as usual, but this thing reminds me of a
> > bug I stared at yesterday night:
> 
> This problem is completely unrelated. My problem was caused by using
> binutils-gold.

Ok, thanks for the update. One thing less to worry about :)

Thanks,

	tglx
