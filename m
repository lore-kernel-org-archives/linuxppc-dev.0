Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 39158DDE16
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 15:31:55 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so361148ywh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 22:31:55 -0700 (PDT)
Message-ID: <fa686aa40806272231s69a895afv61877729acbac7fb@mail.gmail.com>
Date: Fri, 27 Jun 2008 22:31:54 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH 01/12] pata_mpc52xx: use linux/of_platform.h instead of asm
In-Reply-To: <48648AA2.2020204@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<48648AA2.2020204@garzik.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <htejun@gmail.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 11:37 PM, Jeff Garzik <jeff@garzik.org> wrote:
> Stephen Rothwell wrote:
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>  drivers/ata/pata_mpc52xx.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> I am not sure who wants to take this.
>>
>> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
>> index bc79df6..a9e8273 100644
>> --- a/drivers/ata/pata_mpc52xx.c
>> +++ b/drivers/ata/pata_mpc52xx.c
>> @@ -16,10 +16,10 @@
>>  #include <linux/slab.h>
>>  #include <linux/delay.h>
>>  #include <linux/libata.h>
>> +#include <linux/of_platform.h>
>>   #include <asm/types.h>
>>  #include <asm/prom.h>
>> -#include <asm/of_platform.h>
>>  #include <asm/mpc52xx.h>
>
> ACK.  send it via an arch tree

I'll pick it up.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
