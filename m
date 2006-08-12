Return-Path: <osstklei@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0F4C67C0C
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 02:37:09 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7CGb5ap121552
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 16:37:05 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7CGentt090448
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 18:40:49 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7CGb4tf015978
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 18:37:04 +0200
Message-ID: <44DE03B0.1060607@de.ibm.com>
Date: Sat, 12 Aug 2006 18:37:04 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, Jan-Bernd Themann <themann@de.ibm.com>
Subject: Re: [PATCH 3/6] ehea: queue management
References: <44D99F38.8010306@de.ibm.com> <20060811215225.GH479@krispykreme>
In-Reply-To: <20060811215225.GH479@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Blanchard wrote:
> Hi,
>
>   
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_ethtool.c	1969-12-31 
>>     
>
>   
>> +static void netdev_get_pauseparam(struct net_device *dev,
>> +				  struct ethtool_pauseparam *pauseparam)
>> +{
>> +	printk("get pauseparam\n");
>> +}
>>     
>
> There are a number of stubbed out ethtool functions like this. Best not
> to implement them and allow the upper layers to return a correct error.
>
> Anton
>   
I agree, stubbs were removed.

Thomas
