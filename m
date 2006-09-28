Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FC6467BEB
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 00:04:27 +1000 (EST)
In-Reply-To: <IIEEICKJLNEPBBDJICNGKEAEMEAA.chuckmeade@mindspring.com>
References: <IIEEICKJLNEPBBDJICNGKEAEMEAA.chuckmeade@mindspring.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6350370-CB31-4EC5-B877-30AAF4047A57@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/12] qe_lib: Add QE Kconfig
Date: Thu, 28 Sep 2006 09:04:54 -0500
To: Chuck Meade <chuckmeade@mindspring.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 28, 2006, at 8:38 AM, Chuck Meade wrote:

>> Signed-off-by: Li Yang <leoli@freescale.com>
>> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>>
>> ---
>>  arch/powerpc/Kconfig |   12 ++++++++++++
>>  1 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 694b0c6..c907792 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -355,6 +355,16 @@ config APUS
>>  	  <http://linux-apus.sourceforge.net/>.
>>  endchoice
>>
>> +config QUICC_ENGINE
>> +	bool
>> +	depends on MPC836x
>
> The QUICC Engine is on chips other than MPC836x, such as the MPC832x:
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp? 
> code=MPC8323E
>
> Why do you want it to depend on MPC836x?
> Or do you just plan to change this dependency once 832x support is in
> the source tree?

This will change when there is support for MPC832x, its fairly  
normally to start with the first processor that has the feature and  
than add others as time goes on.

- k
