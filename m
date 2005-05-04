Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9590F679F2
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2005 09:21:19 +1000 (EST)
In-Reply-To: <17017.16478.767293.191940@cargo.ozlabs.ibm.com>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
	<17017.16478.767293.191940@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <45e21c1ae2899849665fb894a2adcc20@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 4 May 2005 19:21:10 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 4, 2005, at 5:36 PM, Paul Mackerras wrote:
> Well, what about them?  I didn't change anything for them (except to
> remove the -mstring).  What -mcpu or -mtune options do you want for 
> them?

The only reason I mentioned it is the "new" default behavior of the
compiler is appropriate for only a very small subset of the cores,
and your solution only addresses some of the ones affected.
In the past, the default behavior was fine for all but your
special case :-)

My concern wasn't specifically for which options I wanted, but
rather for the mechanism to set all of them now that it appears
we need to do that.

> No.  We already have enough configuration questions that are
> unanswerable by ordinary mortals.

OK, but we still need some kind of indication from the configuration
process.  It seems to me it would be easier (and more logical) to
have the default behavior work like it has in the past, and use the
special options for the POWER4, which we already know in
the configuration.

Thanks.


	-- Dan
