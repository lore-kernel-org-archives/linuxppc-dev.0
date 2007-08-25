Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B78FADDD0D
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 00:56:57 +1000 (EST)
In-Reply-To: <46CFB1FA.1040705@garzik.org>
References: <Pine.LNX.4.64.0708222144440.6464@blarg.am.freescale.net>
	<46CFB1FA.1040705@garzik.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E7D8272D-4A5F-43ED-A8AB-FAEEE31464AB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ucc_geth: kill unused include
Date: Sat, 25 Aug 2007 09:57:35 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 24, 2007, at 11:37 PM, Jeff Garzik wrote:

> Kumar Gala wrote:
>> The ucc_geth_mii code is based on the gianfar_mii code that use to  
>> include
>> ocp.h.  ucc never need this and it causes issues when we want to kill
>> arch/ppc includes from arch/powerpc.
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> Jeff, if you issue with this for 2.6.23, I'd prefer to push this via
>> the powerpc.git trees in 2.6.24 as part of a larger cleanup.  Let  
>> me know
>> one way or the other.
>> - k
>>  drivers/net/ucc_geth_mii.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>> diff --git a/drivers/net/ucc_geth_mii.c b/drivers/net/ucc_geth_mii.c
>> index 6c257b8..df884f0 100644
>> --- a/drivers/net/ucc_geth_mii.c
>> +++ b/drivers/net/ucc_geth_mii.c
>> @@ -32,7 +32,6 @@
>>  #include <linux/mm.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>> -#include <asm/ocp.h>
>>  #include <linux/crc32.h>
>>  #include <linux/mii.h>
>
> Feel free to push via PPC git

will do.

thanks

- k
