Return-Path: <albert_herranz@yahoo.es>
Received: from smtp137.mail.ukl.yahoo.com (smtp137.mail.ukl.yahoo.com
	[77.238.184.68]) by ozlabs.org (Postfix) with SMTP id 97A42B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 06:07:00 +1100 (EST)
Message-ID: <4B0ADD4D.2010000@yahoo.es>
Date: Mon, 23 Nov 2009 20:06:53 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 07/19] powerpc: gamecube/wii: declare as non-coherent
	platforms
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<200911222320.56871.arnd@arndb.de>
In-Reply-To: <200911222320.56871.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Sunday 22 November 2009, Albert Herranz wrote:
>>  config NOT_COHERENT_CACHE
>>         bool
>> -       depends on 4xx || 8xx || E200 || PPC_MPC512x
>> +       depends on 4xx || 8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
>>         default y
>>  
>>  config CHECK_CACHE_COHERENCY
>> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
>> index 97a2dbc..31487e4 100644
>> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
>> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
>> @@ -93,4 +93,5 @@ config MPC10X_STORE_GATHERING
>>  
>>  config GAMECUBE_COMMON
>>         bool
>> +       select NOT_COHERENT_CACHE
> 
> One of the two (depends and select) is enough. I'd just drop the 'select'
> line here.
> 
> 	Arnd <><
> 

Thanks, I'll fix that.

Cheers,
Albert
