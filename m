Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87AEDDDE2F
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 03:48:01 +1000 (EST)
In-Reply-To: <20071003163907.GA17658@loki.buserror.net>
References: <Pine.LNX.4.64.0710031019260.20394@blarg.am.freescale.net>
	<20071003163907.GA17658@loki.buserror.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9B434147-CB36-4C4B-9EE1-0F446D5F0BA8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Cleaned up whitespace in head_fsl_booke.S
Date: Wed, 3 Oct 2007 12:47:35 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2007, at 11:39 AM, Scott Wood wrote:

> On Wed, Oct 03, 2007 at 10:20:11AM -0500, Kumar Gala wrote:
>>  	/* Invalidate TLB1 */
>> -	li      r9,0x0c
>> +	li	9,0x0c
>
> No 'r'?

damn, one too many chars deleted :)

- k
