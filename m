Return-Path: <SRS0+fe5d3eea650504d0da4d+527+infradead.org+arjan@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2882967A46
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Feb 2005 18:36:56 +1100 (EST)
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <41FECA18.50609@nortelnetworks.com>
References: <41FECA18.50609@nortelnetworks.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 08:36:37 +0100
Message-Id: <1107243398.4208.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on symbol exports
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-01-31 at 18:15 -0600, Chris Friesen wrote:
> It appears that in 2.6.9 the ppc64 version of flush_tlb_page() depends 
> on two symbols which are not currently exported: the function 
> __flush_tlb_pending(), and the per-cpu variable ppc64_tlb_batch.
> 
> Is there any particular reason why modules should not be allowed to 
> flush the tlb, or is this an oversight?

can you point at the url to your module source? I suspect modules doing
tlb flushes is the wrong thing, but without seeing the source it's hard
to tell.
