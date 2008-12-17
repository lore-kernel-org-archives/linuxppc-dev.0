Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D7AFDDFCC
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 03:58:40 +1100 (EST)
Message-Id: <E4C453B2-C0BC-4535-8014-04AB39A6BB49@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081217165552.GA7307@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/5] powerpc/qe: Implement QE Pin Multiplexing API
Date: Wed, 17 Dec 2008 10:56:33 -0600
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
	<20081203192738.GA13035@oksana.dev.rtsoft.ru>
	<20081217154111.GA21335@oksana.dev.rtsoft.ru>
	<C486295F-74E1-4A24-A8FE-C7BD446A53F5@kernel.crashing.org>
	<20081217165552.GA7307@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>
>>>
>>> Kumar, can you please merge this patch? It is the last patch that
>>> holds the FHCI USB driver.
>>>
>>> Thanks,
>>
>> Will do.  Can I get you to add kdoc comments for the API functions:
>
> The functions already have kdoc comments (see qe_lib/gpio.c changes).


Yeah, I noticed that.. sorry about the noise.

- k
