Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 928C2DDF79
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 06:17:08 +1000 (EST)
Message-ID: <480E479C.7040408@ru.mvista.com>
Date: Wed, 23 Apr 2008 00:16:28 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] [MTD] Add support for RAM & ROM mappings
	in	the	physmap_of MTD driver.
References: <200803261344.03438.laurentp@cse-semaphore.com>	
	<47EA6B11.7050804@ru.mvista.com>	
	<777c028aa41fe870542afdb4fa7d2db6@kernel.crashing.org>	
	<200803271026.51555.laurentp@cse-semaphore.com>
	<1208894995.9212.669.camel@pmac.infradead.org>
In-Reply-To: <1208894995.9212.669.camel@pmac.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:

>>Ok. I'll submit a new patch as soon as we agree on a compatible name.

> Did we?

    IIRC, The latest agreement was that we don't need the "compatible" and 
will match on node name.

WBR, Sergei
