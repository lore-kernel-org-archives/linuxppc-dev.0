Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3BEDD679F8
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2005 22:24:20 +1000 (EST)
In-Reply-To: <17017.44421.790813.918463@cargo.ozlabs.ibm.com>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
	<17017.16478.767293.191940@cargo.ozlabs.ibm.com>
	<45e21c1ae2899849665fb894a2adcc20@embeddededge.com>
	<17017.39523.745634.193331@cargo.ozlabs.ibm.com>
	<20050505041225.GX1221@smtp.west.cox.net>
	<17017.42136.824607.253146@cargo.ozlabs.ibm.com>
	<20050505044737.GY1221@smtp.west.cox.net>
	<17017.44421.790813.918463@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7de437cded3ef3b030898889bf65e8c9@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 5 May 2005 08:24:09 -0400
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


On May 5, 2005, at 1:22 AM, Paul Mackerras wrote:
> If you think we should have -mcpu=xxx on the command line for 4xx,
> 44x, 8xx, etc., then that's fine, but that is a separate problem from
> what my patch was addressing (one which my patch might make it easier
> to fix, though).

I think that is exactly what we want, although I don't know how that is
separate from the patch you sent.  My original comment was the patch
fixes the problem for only one of the cpu cores, not all of them.  Which
then led into the subsequent suggestion of making the biarch work
like the past compilers, and we must specific the flags for POWER4
instead of the other way around.  Without explicit -mcpu flags, the
existing compiler behavior is just fine .....  but, I guess I'd be 
standing
in the way of progress to want this :-)

Thanks.

	-- Dan
