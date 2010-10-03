Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id 304DCB70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Oct 2010 05:07:37 +1100 (EST)
Date: Sun, 3 Oct 2010 13:07:31 -0500
From: Robin Holt <holt@sgi.com>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/9] v3 Define memory_block_size_bytes for powerpc/pseries
Message-ID: <20101003180731.GT14064@sgi.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62A0A.4050406@austin.ibm.com>
	<20101003175500.GE7896@balbir.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101003175500.GE7896@balbir.in.ibm.com>
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>, linuxppc-dev@lists.ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 03, 2010 at 11:25:00PM +0530, Balbir Singh wrote:
> * Nathan Fontenot <nfont@austin.ibm.com> [2010-10-01 13:35:54]:
> 
> > Define a version of memory_block_size_bytes() for powerpc/pseries such that
> > a memory block spans an entire lmb.
> 
> I hope I am not missing anything obvious, but why not just call it
> lmb_size, why do we need memblock_size?
> 
> Is lmb_size == memblock_size after your changes true for all
> platforms?

What is an lmb?  I don't recall anything like lmb being referred to in
the rest of the kernel.

Robin
