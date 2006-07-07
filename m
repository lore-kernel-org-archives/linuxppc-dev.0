Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F3C967B62
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 00:36:26 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] dtc: fix endian issue when reading blobs 
In-Reply-To: Your message of "Fri, 07 Jul 2006 23:28:10 +1000."
	<20060707132811.B1A4267B55@ozlabs.org>
References: <20060707055313.E6FC067A2E@ozlabs.org>
	<20060707132811.B1A4267B55@ozlabs.org>
Date: Fri, 07 Jul 2006 09:36:20 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FyrRM-00049Y-8Y@jdl.com>
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Michael Neuling mumbled:
> The reserve mem regions are screwy if you read a blob on x86.  I'm
> guessing there may be a few more of these lurking in the code. 
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> ---
> Oops.. wrong way around.. thanks Milton.
> 
>  flattree.c |    2 ++
>  1 file changed, 2 insertions(+)

Your wish has been granted.

Thanks!

jdl
