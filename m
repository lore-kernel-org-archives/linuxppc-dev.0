Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41AFD1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:26:59 +1000 (AEST)
In-Reply-To: <20150505080529.513.66351.stgit@mars.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: [v2,2/2] powerpc/powernv: Pull all HMI events before panic.
Message-Id: <20150810092659.145671401F6@ozlabs.org>
Date: Mon, 10 Aug 2015 19:26:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-05 at 08:05:43 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> In the event of unrecovered HMI the existing code panics as soon as
> it receives the first unrecovered HMI event. This makes host to report
> partial information about HMIs before panic. There may be more errors
> which would have caused the HMI and hence more HMI event would have been
> generated waiting to be pulled by host. This patch implements a logic to
> pull and display all the HMI event before going down panic path.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1852ae276ba6d5d481c3

cheers
