Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B5C07DDEEE
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 22:33:20 +1100 (EST)
Message-ID: <47CFD607.2000309@ru.mvista.com>
Date: Thu, 06 Mar 2008 14:31:19 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] PowerPC 4xx: Add dcri_clrset() for locked
	read/modify/write functionality
References: <20080305183804.GA21760@ru.mvista.com>	<1204761978.21545.240.camel@pasglop>
	<20080305191216.5089f696@zod.rchland.ibm.com>
In-Reply-To: <20080305191216.5089f696@zod.rchland.ibm.com>
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

Josh Boyer wrote:
> On Thu, 06 Mar 2008 11:06:18 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
>> On Wed, 2008-03-05 at 21:38 +0300, Valentine Barshak wrote:
>>> This adds dcri_clrset() macro which does read/modify/write
>>> on indirect dcr registers while holding indirect dcr lock.
>>>
>>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Indeed, looks good.  Valentine, are you going to rework your EMAC patch
> to use this?
> 
> josh

Yes, I was going to update the pcie stuff and rework the emac patches.

Thanks,
Valentine.
