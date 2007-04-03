Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E206DDE32
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 10:30:13 +1000 (EST)
Date: Tue, 3 Apr 2007 15:14:41 -0700
From: Brad Boyer <flar@allandria.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070403221441.GB13210@cynthia.pants.nu>
References: <1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403.170212.02298297.davem@davemloft.net>
	<1175645568.10567.42.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1175645568.10567.42.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 08:12:48PM -0400, David Woodhouse wrote:
> On Tue, 2007-04-03 at 17:02 -0700, David Miller wrote:
> > Sparc does the same thing, it's a common convention and you really
> > should not break it.
> 
> I thought that argument was lost many years ago. It _used_ to be a
> common convention; we got better.

This argument was made and lost as you say. The problem is that the
resolution was a decision from on high. For the most part, everyone
kept their original opinion and nothing was truly resolved. I think
there was some resentment on the part of the losing side because
they felt their opinions weren't seriously considered. Please
correct me if my impressions of that were wrong. I was not directly
involved in such arguments at the time.

	Brad Boyer
	flar@allandria.com
