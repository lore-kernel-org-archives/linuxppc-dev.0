Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1453367B6C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 05:12:26 +1100 (EST)
In-Reply-To: <4579A76A.7020801@freescale.com>
References: <20061207173353.GD22989@ld0162-tx32.am.freescale.net>
	<161D7B81-B884-4C75-B42E-1627CA538918@kernel.crashing.org>
	<4579A76A.7020801@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CCEB0B9A-3670-4CCA-A4DF-5A7384B85433@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc: Document device nodes for I2C devices.
Date: Fri, 8 Dec 2006 12:12:18 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 8, 2006, at 11:56 AM, Scott Wood wrote:

> Kumar Gala wrote:
>> On Dec 7, 2006, at 11:33 AM, Scott Wood wrote:
>>> +    - reg : I2C address for the device
>> Is this a 7-bit or 8-bit padded address?
>
> It's a 7-bit address.

Was chatting with Ben about this and we should try to mimic the  
behavior of I2C in the device-tree that exists on Apple HW.  He was  
going to look at a tree and let us know if they use 7-bit or 8-bit  
addresses.

- k
