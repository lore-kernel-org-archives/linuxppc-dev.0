Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C9CF2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 03:35:49 +1000 (EST)
Message-ID: <4FFDB968.4080503@freescale.com>
Date: Wed, 11 Jul 2012 12:35:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/mpc8572ds: Fix eTSEC is not available on
 core1 of AMP boot issue
References: <1341900506-23401-1-git-send-email-B38951@freescale.com>
 <4FFC7139.3080303@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A218AA@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A218AA@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2012 09:07 PM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Wednesday, July 11, 2012 2:15 AM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
>> Subject: Re: [PATCH 1/2] powerpc/mpc8572ds: Fix eTSEC is not available on
>> core1 of AMP boot issue
>>
>> On 07/10/2012 01:08 AM, Jia Hongtao wrote:
>>> The issue log on core1 is:
>>> root@mpc8572ds:~# ifconfig eth0 10.192.208.244
>>> net eth0: could not attach to PHY
>>> SIOCSIFFLAGS: No such device
>>>
>>> To attach PHY node mdio@24520 should not be disabled in dts of core1.
>>> Because all PHYs are controlled through this node as follows:
>>
>> So you grant it to both partitions?  How do you deal with synchronization?
>>
>> -Scott
> 
> PHY nodes are only used by ethernet. Each ethernet is used by only one partition
> (disabled in the other partition). So I think there is no synchronization issue.

I mean for accessing the MDIO bus.

-Scott
