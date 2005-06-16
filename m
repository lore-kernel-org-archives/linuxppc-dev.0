Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5004679E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 05:36:04 +1000 (EST)
In-Reply-To: <1278c2c53202b80080519cca60bb438f@freescale.com>
References: <ecc06b51023e6ebd23d075aa3948749e@onz.com>
	<1278c2c53202b80080519cca60bb438f@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <70b519442adfe933ea19959c41ce7195@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 16 Jun 2005 15:36:02 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Ppc Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC cpm2_devices DPRAM resource
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 16, 2005, at 1:58 PM, Kumar Gala wrote:

> Well, we already have an allocator for general dpram memory.  I'm not 
> really sure how this would help beyond reducing the fact that we may 
> ioremap() regions more than once.  I think the better solution there 
> is to look at the patches that have been made to ioremap() to return 
> the same virtual addresses if you are remapping a region of physical 
> memory that already has a mapping.

I agree.  Specifically for 85xx, we have to make sure we have CAMs 
mapping
these spaces and ioremap() will reuse them.


	-- Dan
