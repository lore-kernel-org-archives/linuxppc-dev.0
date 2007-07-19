Return-Path: <brking@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 613D2DDF22
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 04:28:31 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l6JHMghT012480
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 13:22:42 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6JISRWa168824
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 12:28:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6JISRgU009060
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 12:28:27 -0600
Message-ID: <469FAD4A.7090402@linux.vnet.ibm.com>
Date: Thu, 19 Jul 2007 13:28:26 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Subject: Re: [PATCH 2/4] ibmveth: Implement ethtool hooks to enable/disable
	checksum offload
References: <1184860086366-patch-mail.ibm.com>
	<200707191548.l6JFmEYM020387@d03av04.boulder.ibm.com>
	<469F8C80.7070302@indt.org.br>
	<469FA68F.9070607@linux.vnet.ibm.com>
	<469FAA9F.9010207@indt.org.br>
In-Reply-To: <469FAA9F.9010207@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, rcjenn@linux.vnet.ibm.com,
	santil@linux.vnet.ibm.com, netdev@vger.kernel.org
Reply-To: brking@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ragner Magalhaes wrote:
> ext Brian King wrote:
>> Ragner Magalhaes wrote:
>>> here also, as above ...
>>>> +	if (data && (dev->features & NETIF_F_IP_CSUM))
>>>> +		return 0;
>>>> +	if (!data && !(dev->features & NETIF_F_IP_CSUM))
>>>> +		return 0;
>> This change would make the line > 80 columns, which I prefer to avoid.
>> Updated patch attached which addresses the first comment.
> I think would not be ugly to make.
> 
> 	if ((data && (dev->features & NETIF_F_IP_CSUM)) ||
> 		(!data && !(dev->features & NETIF_F_IP_CSUM)))
> 		return 0;

I find that less readable than what I currently have.

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
