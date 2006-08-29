Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0456267B5B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 01:34:27 +1000 (EST)
Message-ID: <44F45EC5.2070904@ru.mvista.com>
Date: Tue, 29 Aug 2006 19:35:33 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] corrected PCI interrupt sense values to level low in
	mpc8349emds.dts
References: <20060828174910.236bf042.kim.phillips@freescale.com>
	<44F45CDD.5060206@ru.mvista.com>
In-Reply-To: <44F45CDD.5060206@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:
>> Corrected PCI interrupt sense values to level low in mpc8349emds.dts, 
>> per Leo's recommendation.

>> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>> ---

>> applies on top of "[PATCH 4/4] Add MPC8349E MDS device tree source 
>> file to arch/powerpc/boot/dts"

>>  arch/powerpc/boot/dts/mpc8349emds.dts |  112 
>> +++++++++++++++++----------------
>>  1 files changed, 56 insertions(+), 56 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts 
>> b/arch/powerpc/boot/dts/mpc8349emds.dts
>> index 7e4508b..0643db9 100644
>> --- a/arch/powerpc/boot/dts/mpc8349emds.dts
>> +++ b/arch/powerpc/boot/dts/mpc8349emds.dts
>> @@ -178,46 +178,46 @@
>>              interrupt-map = <
>>  
>>                      /* IDSEL 0x11 */
>> -                     8800 0 0 1 700 14 0
>> -                     8800 0 0 2 700 15 0
>> -                     8800 0 0 3 700 16 0
>> -                     8800 0 0 4 700 17 0
>> +                     8800 0 0 1 700 14 2
>> +                     8800 0 0 2 700 15 2
>> +                     8800 0 0 3 700 16 2
>> +                     8800 0 0 4 700 17 2

>    Since when 2 means level low? 2 is level high, 1 is level low.

   Ah, this board uses IPIC, not OpenPIC. Anyway, this contradicts your own 
comment to the "ipic" device node stating that 8 is the right value for level low.

WBR, Sergei
