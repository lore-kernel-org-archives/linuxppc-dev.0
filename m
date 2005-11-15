Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <269d7972781989e47cc114f8e2124b80@freescale.com>
References: <1132001719.5504.204.camel@gaston>
	<269d7972781989e47cc114f8e2124b80@freescale.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 16:35:09 +1100
Message-Id: <1132032910.23979.6.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-14 at 23:10 -0600, Becky Bruce wrote:
> Ben,
> 
> I've just done some basic testing of lmw/stmw, lwz/stw, lhx/sth, 
> lfs/stfs, and lfd/stfd misaligned across a doubleword boundary, and 
> everything looks good so far.   I'll check out the byte reversals and a 
> few other forms tomorrow.

Excellent, thanks ! BTW. Make sure you test these one CPUs that actually
trap on misaligned accesses :) Best is probably to do the misaligned
access accross a page boundary, that's what most CPUs can do.

Ben.
