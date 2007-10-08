Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5643DDFDC
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 06:46:30 +1000 (EST)
In-Reply-To: <20071008203754.12243.1712.stgit@trillian.cg.shawcable.net>
References: <20071008203754.12243.1712.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <34DC57DB-3C62-4CFA-ADD3-6A4CC8CDAB6B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Only call ppc_md.setup_arch() if it is provided.
Date: Mon, 8 Oct 2007 15:45:59 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2007, at 3:37 PM, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
>
> This allows platforms which don't have anything to do at setup_arch  
> time
> (like a bunch of the 4xx platforms) to eliminate an empty  
> setup_arch hook.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

Can you add a comment to include/asm-powerpc/machdep.h to state that  
setup_arch() /* Optional, may be NULL */

We're a bit inconsistent here but would be good to make changes be  
correct.

- k
