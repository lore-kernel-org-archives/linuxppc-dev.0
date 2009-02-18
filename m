Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2E06BDDF71
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 18:46:08 +1100 (EST)
Date: Wed, 18 Feb 2009 08:47:39 +0100
From: Benjamin Krill <ben@codiert.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] Check name property to determine partition nodes.
Message-ID: <20090218074738.GC12204@codiert.org>
References: <20090123161805.GA2598@codiert.org>
	<1233720542.16867.187.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1233720542.16867.187.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, vwool@ru.mvista.com, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt | 2009-02-04 15:09:02 [+1100]:
>On Fri, 2009-01-23 at 17:18 +0100, Benjamin Krill wrote:
>> SLOF has a further node which could not be evaluate
>> by the current routine. The current routine returns
>> because the node hasn't the required reg property. As
>> fix this patch adds a check to determine the partition
>> child nodes. If the node is not an partition the number
>> of total partitions will be decreased and loop continue
>> with the next nodes.
>
>Somebody on the MTD list is taking that ? David ? Or should I merge it
>via powerpc ?

Could somebody merge it for the next release?

 Ben
