Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 456FAB7B6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 23:56:19 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AACF4DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 23:56:18 +1000 (EST)
Message-Id: <51514DBF-F4DF-4CC4-BCE7-96E4726BD854@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20090825135241.GA20036@codiert.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] MTD ofpart: Check availability of reg property instead of
	name property
Date: Tue, 25 Aug 2009 08:55:34 -0500
References: <20090825135241.GA20036@codiert.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 25, 2009, at 8:52 AM, Benjamin Krill wrote:

> The previous implementation breaks the dts binding "mtd- 
> physmap.txt". This
> implementation fixes the issue by checking the availability of the reg
> property instead of the name property.
>
> Signed-off-by: Benjamin Krill <ben@codiert.org>
> ---
> drivers/mtd/ofpart.c |   21 ++++++++++-----------
> 1 files changed, 10 insertions(+), 11 deletions(-)

David,

Can you look at pushing this for .31 if possible.  We have a # of  
device trees in the kernel which have "broken" functionality because  
of this.

- k
