Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B991567B8D
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 04:50:27 +1000 (EST)
In-Reply-To: <20060928204345.4e23789e@vitb.ru.mvista.com>
References: <451B8584.1070403@freescale.com>
	<9672B4B6-1DC0-48D6-99BA-7160421CB24C@kernel.crashing.org>
	<20060928204345.4e23789e@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B51556B9-EEB4-4BF6-8F71-FE2A0167B431@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 8/12] qe_lib: Fix rheap alignment problem
Date: Thu, 28 Sep 2006 13:50:53 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Li Yang <leoli@freescale.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 28, 2006, at 11:43 AM, Vitaly Bordug wrote:

> On Thu, 28 Sep 2006 09:10:18 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>
>> On Sep 28, 2006, at 3:19 AM, Li Yang wrote:
>>
>>> Honor alignment parameter in the rheap allocator.  This is
>>> needed by qe_lib.
>>> Remove compile warning.
>>>
>>> Signed-off-by: Pantelis Antoniou <pantelis@embeddedalley.com>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>
>
> OK, I can state rheap is still consistent in 8560 cpm2.
> It even makes sense to apply this instantly because it's a notable  
> bugfix.. Kumar?

Good, I wanted to pull this out of QE patch set and since it fixes a  
bug even better.

Acked by me.

- kumar
