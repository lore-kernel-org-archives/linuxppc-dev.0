Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 022DD67B50
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 01:31:21 +1000 (EST)
In-Reply-To: <7f0a378a4f3b17a9db01773fcca5fafd@freescale.com>
References: <83a359bdf2c4d4902f58e6788c37811a@embeddededge.com>
	<7f0a378a4f3b17a9db01773fcca5fafd@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0a78c3014267e43974c3006e950a02bc@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 12 Apr 2005 11:31:12 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] ppc32: Fix alignment exception checking on load/store
	multiple instructions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 12, 2005, at 11:06 AM, Kumar Gala wrote:

> When you say "fix up" I assume you mean lwarx should return 0.  It 
> appears that stwcx. is already doing that.  Can't think of any other 
> cases that need fixing.

Yes, it should return an error.  From a quick look at the slicing of the
bits in the code, it appears lawrx is decoded the same as lw.

Thanks.

	-- Dan
