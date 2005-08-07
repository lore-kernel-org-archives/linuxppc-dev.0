Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E5F067F02
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 13:36:01 +1000 (EST)
In-Reply-To: <20050806234244.GB5210@cathedrallabs.org>
References: <20050806180353.GW5210@cathedrallabs.org>
	<20050806232701.GD1099@dmt.cnet>
	<20050806234244.GB5210@cathedrallabs.org>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d74e24bbf82e4cedd3358465343d28ae@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 6 Aug 2005 23:36:16 -0400
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 6, 2005, at 7:42 PM, Aristeu Sergio Rozanski Filho wrote:

> but not with EXPORT_SYMBOL(). I noticed this while compiling i2c stuff
> as module. also, I think it's better add a function to do this instead
> doing EXPORT_SYMBOL() in a variable.

Right.  We should just ioremap() :-)

Thanks.

	-- Dan
