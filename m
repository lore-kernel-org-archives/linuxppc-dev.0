Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42D3D679EB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 09:11:08 +1000 (EST)
In-Reply-To: <3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <59a68b5b844da7826bb83940af515693@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 6 May 2005 19:10:36 -0400
To: Dan Malek <dan@embeddededge.com>
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


On May 6, 2005, at 6:49 PM, Dan Malek wrote:

>> 3) Memory for DMA pages must not be in the pinned region. ie. drivers
>> should not allocate memory directly for DMA purposes.
>
> Why not?

Having now read this again, the "Why not?" was for the first
sentence :-)

Drivers should always use the proper dma allocation functions.
Unpredictable and sometimes exciting results can happen if
they don't.

Thanks.


	-- Dan
