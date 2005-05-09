Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99439679F1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 05:25:37 +1000 (EST)
In-Reply-To: <20050507214739.GF16996@logos.cnet>
References: <20050506154539.GA6452@logos.cnet>
	<52dc3ae70f883699b1e48b7d742afcaf@embeddededge.com>
	<20050507214739.GF16996@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <29691e55deb3a0f32278926ccabe2714@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 9 May 2005 15:25:31 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: How to fix 8xx dcbst bug?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 7, 2005, at 5:47 PM, Marcelo Tosatti wrote:

> So, for sys_read() v2.6 i-cache translation footprint is about 100%
> more than v2.4.

It could actually be something as "simple" as the organization
of the functions in the image.  Would you also send along the
portion of the System.map that covers these kernel address
ranges?  There is only one additional user space TLB, which
is probably the C library, all of the rest are kernel ones.

For example, what functions are in the range of 0xc009c00,
0xc009d000, 0xc009e000, and in the 0xc0003000
pages for your 2.4 kernel?

Thanks.

	-- Dan
