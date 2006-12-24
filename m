Return-Path: <ahuja@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 07BD6DDEDA
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Dec 2006 03:57:07 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBOGusvu026070
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Dec 2006 11:56:54 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBOGusRC552866
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Dec 2006 09:56:54 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBOGurSX011322
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Dec 2006 09:56:53 -0700
Message-ID: <458EB149.9010706@austin.ibm.com>
Date: Sun, 24 Dec 2006 10:56:41 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
References: <45707469.9060604@austin.ibm.com>	<4575E76C.7030300@austin.ibm.com>
	<17785.415.574041.518517@cargo.ozlabs.ibm.com>
In-Reply-To: <17785.415.574041.518517@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Okay,

Will post the new patch in a few hours.

was out sick and on vacation so didnt get a chance to do the needful.

-M



Paul Mackerras wrote:
> Manish Ahuja writes:
>
>   
>> During power outages, the ups notifies the system for a shutdown. In the 
>> current setup, it isn't possible to power on when power is restored. 
>> This patch fixes the issue by calling the right ibm,power-off-ups token 
>> during such events. It also adds a proc interface so that rc.powerfail 
>> can parse the epow events and modify the power-off behavior accordingly 
>> to enable the right token to be called.
>>     
>
> With this patch, the kernel won't build if CONFIG_PPC_RTAS=y and
> CONFIG_RTAS_PROC=n.  Please move the definition of rtas_poweron_auto
> from rtas-proc.c to rtas.c so that this (admittedly somewhat strange)
> config will build.
>
> Thanks,
> Paul.
>   
