Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 219E767B5A
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 16:57:57 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7E6vq56121760
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 06:57:52 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7E71eEn140916
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 09:01:40 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7E6vqND008460
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 08:57:52 +0200
Message-ID: <44E015D5.8040301@de.ibm.com>
Date: Mon, 14 Aug 2006 08:19:01 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 4/6] ehea: header files
References: <44D99F56.7010201@de.ibm.com> <20060811214020.GG479@krispykreme>
	<1155525611.7807.4.camel@localhost.localdomain>
In-Reply-To: <1155525611.7807.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Anton Blanchard <anton@samba.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Sat, 2006-08-12 at 07:40 +1000, Anton Blanchard wrote:
>> Hi,
>>
>>>  drivers/net/ehea/ehea.h    |  452 
>>> +#define EHEA_DRIVER_NAME	"IBM eHEA"
>> You are using this for ethtool get_drvinfo. Im not sure if it should
>> match the module name, and I worry about having a space in the name. Any
>> ideas on what we should be doing here?
> 
> I believe it must match the module name. It also might be nice to call
> it "DRV_NAME" like most other network drivers do.
> 
> cheers
> 


We rename EHEA_DRIVER_NAME to DRV_NAME (and EHEA_DRIVER_VERSION
to DRV_VERSION) and assign "ehea" to it

Jan-Bernd
