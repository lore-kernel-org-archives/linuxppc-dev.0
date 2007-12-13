Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 95835DE07E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 01:07:02 +1100 (EST)
Date: Thu, 13 Dec 2007 17:09:57 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
Message-ID: <20071213140957.GA25401@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071212164035.GB4329@loki.buserror.net>
	<20071212165513.GA30981@localhost.localdomain>
	<47601245.2090907@freescale.com>
	<20071212205838.GA16425@localhost.localdomain>
	<47604D6E.1050200@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47604D6E.1050200@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 03:06:54PM -0600, Scott Wood wrote:
[...]
> >Given that, personally I'd want to lockless variant to stay.
> >
> >So, you still want to get rid of it?
> 
> Yes, in the absence of benchmarking that shows it makes a real 
> difference.

Benchmarking shows no difference in throughput between lock and
lockless variants. This is expected of course, flashes are slow,
so I can't really benchmark anything with it.

> Premature optimization being the root of all evil, and what 
> not.

;-) Will remove it, thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
