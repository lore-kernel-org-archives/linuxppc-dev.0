Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C544CDDF1D
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 13:08:19 +1000 (EST)
In-Reply-To: <20070823024937.GD7042@localhost.localdomain>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<20070822143047.6c8a0d4e@weaponx.rchland.ibm.com>
	<20070823024937.GD7042@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4FA0E2BC-BDD3-403F-882F-C2CDEC53BBC8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Date: Wed, 22 Aug 2007 22:09:52 -0500
To: David Gibson <dwg@au1.ibm.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 9:49 PM, David Gibson wrote:

> On Wed, Aug 22, 2007 at 02:30:47PM -0500, Josh Boyer wrote:
>> On Wed, 22 Aug 2007 10:19:21 -0500
>> Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>>> Guys,
>>>
>>> I was wondering if I could get your help with looking at the
>>> following lists and determining if we have an issue or not related
>>> the following files:
>>>
>>> Getting some classification on these would be good.  Possibly
>>> classifications, doesn't build in ARCH=powerpc, remove include, real
>>> issue, etc.
>>
>> Sure.
>>
>>> ./drivers/i2c/busses/i2c-ibm_iic.c:#include <asm/ocp.h>
>>> ./drivers/i2c/busses/i2c-ibm_iic.c:#include <asm/ibm4xx.h>
>>
>> These one depends on IBM_OCP in Kconfig.  We don't select/enable  
>> that on
>> any existing arch/powerpc 4xx stuff so it won't be built anyway.
>
> Nor will we ever enable IBM_OCP in arch/powerpc: the device tree
> entirely obsoletes the OCP crap.

Agreed.  We shouldn't taint arch/powerpc with OCP :)

- k
