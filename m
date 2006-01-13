Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-32.bluehost.com (outbound-mail-32.bluehost.com
	[70.96.188.152]) by ozlabs.org (Postfix) with SMTP id 4FCAA689C8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 04:52:48 +1100 (EST)
Message-ID: <43C7E8DD.2010200@secretlab.ca>
Date: Fri, 13 Jan 2006 10:52:29 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: [PATCH 02/10] Make Virtex-II Pro support generic for all Virtex
	devices
References: <1136795579525-git-send-email-grant.likely@secretlab.ca>
	<43C691C2.9090607@ru.mvista.com>
In-Reply-To: <43C691C2.9090607@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: glikely@gmail.com, dhlii@dlasys.net, gnathita@gmail.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrei Konovalov wrote:
> grant.likely@secretlab.ca wrote:
> 
>> The PPC405 hard core is used in both the Virtex-II Pro and Virtex 4 FX
>> FPGAs.  This patch cleans up the Virtex naming convention to reflect more
>> than just the Virtex-II Pro.
>>
>> Rename files virtex-ii_pro.[ch] to virtex.[ch]
>> Rename config value VIRTEX_II_PRO to XILINX_VIRTEX
>>
>> Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>
>>
>> ---
> 
> 
> Here is a misprint:
> 
>>
> ...
> 
>> diff --git a/arch/ppc/platforms/4xx/virtex.c 
>> b/arch/ppc/platforms/4xx/virtex.c
>> new file mode 100644
>> index 0000000..1de7a27
>> --- /dev/null
>> +++ b/arch/ppc/platforms/4xx/virtex.c
>> @@ -0,0 +1,60 @@
>> +/*
>> + * arch/ppc/platforms/4xx/virtex.c
>> + *
>> + * Author: MontaVista Software, Inc.
>> + *         source@mvista.com
>> + *
>> + * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed 
>> under the
>> + * terms of the GNU General Public License version 2.  This program 
>> is licensed
>> + * "as is" without any warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/config.h>
>> +#include <linux/init.h>
>> +#include <asm/ocp.h>
>> +#include <platform/4xx/virtex.h>
> 
> 
> Should be
> #include <platforms/4xx/virtex.h>
oops, the 's' got added in one of the later patches.  Don't know how I 
managed that.

Thanks


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
