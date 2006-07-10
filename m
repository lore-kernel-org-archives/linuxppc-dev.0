Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 5497167B67
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 21:31:24 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060708111243.28664.74956.sendpatchset@skynet.skynet.ie> 
References: <20060708111243.28664.74956.sendpatchset@skynet.skynet.ie>
	<20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 6/6] Account for memmap and optionally the kernel image as
	holes
Date: Mon, 10 Jul 2006 12:30:55 +0100
Message-ID: <7220.1152531055@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
Cc: akpm@osdl.org, davej@codemonkey.org.uk, tony.luck@intel.com,
	linuxppc-dev@ozlabs.org, ak@suse.de, bob.picco@hp.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mel Gorman <mel@csn.ul.ie> wrote:

> +unsigned long __initdata dma_reserve;

Should this be static?  Or should it be predeclared in a header file
somewhere?

David
