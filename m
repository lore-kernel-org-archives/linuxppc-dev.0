Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4AF5B67A6D
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 02:16:50 +1000 (EST)
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0D30@rennsmail02.eu.thmulti.com>
References: <1CFEB358338412458B21FAA0D78FE86D4F0D30@rennsmail02.eu.thmulti.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <eb2265e895a6c9f6d6996813d564b4db@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 5 Apr 2005 12:16:28 -0400
To: "Fillod Stephane" <stephane.fillod@thomson.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 5, 2005, at 8:24 AM, Fillod Stephane wrote:

> Speaking for myself, I don't plan on using the SPE FPU of the e500,

Why?

> It seems you didn't like my last patch which lets make enter the
> math-emu
> subdirectory only to compile the load/store (8xx could do that too).
> Would you prefer a fix along the line of Soft_emulate_8xx() ?

I'm not sure.  I need to think about it for a moment.  I was rushed to
do some travel, and now I'm back to work on it.

> I don't know what Kumar and his team have in mind for the e500,

The e500 tools use the SPE FPU for all single precision floating
point.  For our initial development we used the floating point 
emulation.


	-- Dan
