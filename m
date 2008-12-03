Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5C5ADDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 03:44:25 +1100 (EST)
Message-Id: <965E56B6-4317-448E-9541-9CB1615E623B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081203162723.GA32301@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH for 2.6.28] NAND: fsl_upm: fix build problem with
	2.6.28-rc2
Date: Wed, 3 Dec 2008 10:43:12 -0600
References: <20081126163840.GA21669@oksana.dev.rtsoft.ru>
	<4A183575-1142-4EC2-83C4-145E721E6E8D@kernel.crashing.org>
	<20081203162723.GA32301@oksana.dev.rtsoft.ru>
Cc: linux-kernel Kernel <linux-kernel@vger.kernel.org>,
	linux-ppc list <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 3, 2008, at 10:27 AM, Anton Vorontsov wrote:

> On Wed, Dec 03, 2008 at 09:47:53AM -0600, Kumar Gala wrote:
> [...]
>>> The patch fixes following build error:
>>>
>>> CC      drivers/mtd/nand/fsl_upm.o
>>> drivers/mtd/nand/fsl_upm.c: In function 'fun_chip_init':
>>> drivers/mtd/nand/fsl_upm.c:168: warning: passing argument 2 of
>>> 'of_mtd_parse_partitions' from incompatible pointer type
>>> drivers/mtd/nand/fsl_upm.c:168: warning: passing argument 3 of
>>> 'of_mtd_parse_partitions' from incompatible pointer type
>>> drivers/mtd/nand/fsl_upm.c:168: error: too many arguments to  
>>> function
>>> 'of_mtd_parse_partitions'
>>> make[1]: *** [drivers/mtd/nand/fsl_upm.o] Error 1
>>>
>>> The breakage was introduced in
>>> 69fd3a8d098faf41a04930afa83757c0555ee360
>>> ("[MTD] remove unused mtd parameter in of_mtd_parse_partitions()").
>>>
>>> While at it, also add a check for the of_mtd_parse_partitions()  
>>> return
>>> value.
>>>
>>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> [...]
>> David,
>>
>> what's going on with this patch?
>
> Recently I got email from Andrew's patch tracking system that
> the patch was merged into subsystem tree. Here it is:
>
> http://git.infradead.org/mtd-2.6.git?a=commitdiff;h=29b65861fbece04cfdf3fee352d5247369131850

is it going into 2.6.28 or waiting for .29?

- k
