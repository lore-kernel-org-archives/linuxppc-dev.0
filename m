Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7962267A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 08:09:23 +1000 (EST)
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHGEIJCLAA.Joakim.Tjernlund@lumentis.se>
References: <BCEFJBPJCGFCNMMMIDBHGEIJCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <566734ff0041d23c5457afc51958ddcf@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 23 Apr 2005 18:09:11 -0400
To: <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 23, 2005, at 5:51 PM, Joakim Tjernlund wrote:

> Well, every instruction counts. I this case we would have saved
> 2 in ITLB Miss, 3 in DTLB Miss and a cache line write in both.

You have already read the PTE and instructions into the cache,
there are no branches, but not a big deal.

> Would be nice to do away with the kernel space test, but thats a lot 
> harder.

With some clever first level pointer page creation and management
we could do this, but it would be custom 8xx code in generic files.

Thanks.

	-- Dan
