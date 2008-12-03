Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 71EB9DDDEF
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 03:27:27 +1100 (EST)
Date: Wed, 3 Dec 2008 19:27:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH for 2.6.28] NAND: fsl_upm: fix build problem with
	2.6.28-rc2
Message-ID: <20081203162723.GA32301@oksana.dev.rtsoft.ru>
References: <20081126163840.GA21669@oksana.dev.rtsoft.ru>
	<4A183575-1142-4EC2-83C4-145E721E6E8D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4A183575-1142-4EC2-83C4-145E721E6E8D@kernel.crashing.org>
Cc: linux-kernel Kernel <linux-kernel@vger.kernel.org>,
	linux-ppc list <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 03, 2008 at 09:47:53AM -0600, Kumar Gala wrote:
[...]
>> The patch fixes following build error:
>>
>>  CC      drivers/mtd/nand/fsl_upm.o
>> drivers/mtd/nand/fsl_upm.c: In function 'fun_chip_init':
>> drivers/mtd/nand/fsl_upm.c:168: warning: passing argument 2 of  
>> 'of_mtd_parse_partitions' from incompatible pointer type
>> drivers/mtd/nand/fsl_upm.c:168: warning: passing argument 3 of  
>> 'of_mtd_parse_partitions' from incompatible pointer type
>> drivers/mtd/nand/fsl_upm.c:168: error: too many arguments to function 
>> 'of_mtd_parse_partitions'
>> make[1]: *** [drivers/mtd/nand/fsl_upm.o] Error 1
>>
>> The breakage was introduced in  
>> 69fd3a8d098faf41a04930afa83757c0555ee360
>> ("[MTD] remove unused mtd parameter in of_mtd_parse_partitions()").
>>
>> While at it, also add a check for the of_mtd_parse_partitions() return
>> value.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
[...]
> David,
>
> what's going on with this patch?

Recently I got email from Andrew's patch tracking system that
the patch was merged into subsystem tree. Here it is:

http://git.infradead.org/mtd-2.6.git?a=commitdiff;h=29b65861fbece04cfdf3fee352d5247369131850

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
