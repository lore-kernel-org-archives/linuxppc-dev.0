Return-Path: <dan@embeddedalley.com>
Received: from penguin.embeddededge.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA038DDEC2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 02:40:12 +1000 (EST)
In-Reply-To: <47162AE7.80305@freescale.com>
References: <20071015233839.959F4247BB@gemini.denx.de>
	<4714E44F.7030909@freescale.com>
	<85100356-D95B-4343-98BE-66080EA9887D@embeddedalley.com>
	<47162AE7.80305@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5E6FFDE1-D706-4460-8621-0BFA38FDC502@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: mpc 860 boot linux2.6.23 problem
Date: Wed, 17 Oct 2007 12:40:33 -0400
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 17, 2007, at 11:31 AM, Scott Wood wrote:

> I just pulled Wolfgang's latest u-boot tree, and I don't see any  
> fdt or ft_ calls in cpu/mpc8xx, nor in any 8xx board that I recognize.

The STx XTc 885 is supported and was used for
a majority of the FT development in u-boot.  I
just built it a few months ago, it worked fine, so
if it isn't working today the changes should be
minimal to bring it up to date.

Thanks.

	-- Dan
