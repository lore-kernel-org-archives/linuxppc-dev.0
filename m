Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD1F867A3B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2005 22:12:53 +1000 (EST)
In-Reply-To: <17017.42136.824607.253146@cargo.ozlabs.ibm.com>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
	<17017.16478.767293.191940@cargo.ozlabs.ibm.com>
	<45e21c1ae2899849665fb894a2adcc20@embeddededge.com>
	<17017.39523.745634.193331@cargo.ozlabs.ibm.com>
	<20050505041225.GX1221@smtp.west.cox.net>
	<17017.42136.824607.253146@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <74e4ebe2933fc8b81b86b8e645a98f1c@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 5 May 2005 08:12:39 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 5, 2005, at 12:44 AM, Paul Mackerras wrote:

> The problem only comes up if you configure gcc4 as biarch.  I can't
> imagine anyone building a biarch compiler for 4xx or 8xx. :)

Why not?  I've never built a "special" compiler for any development
work, and am very likely to use the default compiler installed on
my YDL system (which could likely be a G5) for building any
embedded PowerPC software.

> So yes, only CONFIG_6xx is affected by biarch gcc4 assuming POWER4.
> Other families would only be affected if you were using a generic
> gcc4, which won't work at present anyway, since we don't add
> -mcpu=xxx.

What do you mean by "won't work"?  The compiler simply refuses
or builds for a POWER4 because we don't have the proper -mcpu
flags?

Thanks.


	-- Dan
