Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8593CDDE37
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 22:29:12 +1000 (EST)
Date: Fri, 5 Oct 2007 16:30:03 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH][POWERPC] QEIC: Implement pluggable handlers, fix
	MPIC cascading
Message-ID: <20071005123003.GA1260@localhost.localdomain>
References: <20071004130454.GA15448@localhost.localdomain>
	<1191535520.28239.2.camel@pasglop>
	<E6B4F79B-254F-4273-8E49-D15BCFF6955A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <E6B4F79B-254F-4273-8E49-D15BCFF6955A@kernel.crashing.org>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 05, 2007 at 12:18:58AM -0500, Kumar Gala wrote:
[...]
>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>
>> Looks allright, if it also works, then ship it :-)
>>
>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Now that this has been ack'd by Ben if you can respin the patch set we can 
> get these in for 2.6.24

Great, will do.

> (I assume you are using a UCC as ethernet for test some of the QE support 
> on 8568?)

Yup, UCC as eth. Plus I've also tested SPI (which is in QE) in
loopback mode.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
