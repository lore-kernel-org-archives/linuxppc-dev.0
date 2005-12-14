Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A8B8068879
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 07:13:00 +1100 (EST)
In-Reply-To: <43A03821.6040206@intracom.gr>
References: <5b74ec4d0512140628y42986bc0h2f107e788dd115b6@mail.gmail.com>
	<43A03821.6040206@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2750D02C-4FDE-4267-8B60-E1CECDFF55F4@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Wed, 14 Dec 2005 14:13:00 -0600
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Robin Mathew <robbinmathew@gmail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: 8260 ethernet driver multicast problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 14, 2005, at 09:20, Pantelis Antoniou wrote:

> Robin Mathew wrote:
>> Hi,
>> I was encountering a problem with the receipt of multicast packets  
>> from eth
>> interface in 8260 platform. The issue was traced to the fcc_enet.c  
>> driver. A
>> stray return in the set_multicast_list function was the culprit.
>> The following is the changes that I have made-
>> Index: fcc_enet.c
>> @@ -1488,7 +1488,6 @@
>>      cep = (struct fcc_enet_private *)dev->priv;
>> -return;
>>      /* Get pointer to FCC area in parameter RAM.
>>      */
>>      ep = (fcc_enet_t *)dev->base_addr;
>> Can you please tell me whether there is any issue with setting the  
>> driver in
>> multicast or promiscous mode. Was this change deliberately done or  
>> is it
>> really a bug?
>> Thanks in advance,
>> Robin
>
> Robin, what's the kernel version you're using?
>
> If you're using 2.6 there's a brand new driver you can use.


Has 8260 platform support been pushed out yet?
