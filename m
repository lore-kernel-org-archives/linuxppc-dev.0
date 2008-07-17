Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55520DE3C2
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 22:26:28 +1000 (EST)
Message-Id: <D59ED865-85CF-4C1E-9D79-D9DD0DE49505@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20080717121758.GA25267@gondor.apana.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 4/6] crypto: talitos - fix GFP flag usage
Date: Thu, 17 Jul 2008 07:26:14 -0500
References: <20080716182215.36c1bd11.kim.phillips@freescale.com>
	<BDCB5191-EEDE-4046-A741-80E6EF1333CF@kernel.crashing.org>
	<20080717121758.GA25267@gondor.apana.org.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2008, at 7:17 AM, Herbert Xu wrote:

> On Wed, Jul 16, 2008 at 06:33:45PM -0500, Kumar Gala wrote:
>>
>> On Jul 16, 2008, at 6:22 PM, Kim Phillips wrote:
>>
>>> use GFP_ATOMIC when necessary; use atomic_t when allocating
>>> submit_count.
>>
>> why?
>
> You mean why are atomics required? Yes that is a good question.

Yep. the commit message isn't explaining why, just what :)

> Kim?

- k
