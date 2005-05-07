Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99D1E679EA
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 06:02:49 +1000 (EST)
In-Reply-To: <20050507131609.GA16996@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
	<20050506200338.GC14486@logos.cnet>
	<84773f72b8bba863c9471c0d121223a8@embeddededge.com>
	<20050506230523.GA15908@logos.cnet>
	<6f231f4afce0886929ca99426a86b47a@embeddededge.com>
	<20050507131609.GA16996@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <42e4582f0d1644c2ece0a2cb86f49003@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 7 May 2005 16:02:34 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 7, 2005, at 9:16 AM, Marcelo Tosatti wrote:

> Not creating 4kb mappings for the first 8Mbytes of kernel
> virtual addresses fixed the problem for me.

Fixed what problem?

In the TLB dump, you replaced the initial 8M entry with
a bunch of 4K page entries, just as I would have expected
to happen.  Since it was able to run and load these, the
complete PTE tables must have been created.

How did you "not create" the 4K mappings?

Thanks.

	-- Dan
