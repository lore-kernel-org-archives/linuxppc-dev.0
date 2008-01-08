Return-Path: <jrigby@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0800DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:16:59 +1100 (EST)
Message-ID: <4783BE15.5040604@freescale.com>
Date: Tue, 08 Jan 2008 11:16:53 -0700
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/7] Basic Freescale MPC512x support
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<20080108174038.GA20819@lixom.net>
In-Reply-To: <20080108174038.GA20819@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>
>   
>> @@ -229,7 +229,7 @@ config NR_CPUS
>>  
>>  config NOT_COHERENT_CACHE
>>  	bool
>> -	depends on 4xx || 8xx || E200
>> +	depends on 4xx || 8xx || E200 || PPC_512x
>>  	default y
>>     
>
> Why do you need this, when 5200 doesn't?
>
>   
Because the 5121 cache is not coherent.  The 5121 is not that similar
to 52xx.
> -Olof
>
>   
