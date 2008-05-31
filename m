Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7A6DDDE20
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 16:04:19 +1000 (EST)
Message-Id: <2B008ABE-577A-48DF-89F5-3190979DC622@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18496.57794.862854.470430@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Fix DMA nodes in the MPC8610 HPCD device tree
Date: Sat, 31 May 2008 01:04:14 -0500
References: <1212185525-20944-1-git-send-email-timur@freescale.com>
	<18496.57794.862854.470430@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 31, 2008, at 12:27 AM, Paul Mackerras wrote:

> Timur Tabi writes:
>
>> The node for DMA2 in the MPC8610 HPCD device tree has the wrong  
>> compatible
>> properties.  This breaks the DMA driver and the sound driver.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>> ---
>>
>> I have no idea how I let this bug slip in, but this is a must-fix  
>> for 2.6.26.
>
> Kumar, do you have anything else for 2.6.26 at the moment?  If not,
> and this patch is OK with you, I'll put it in along with Olof's two
> patches and send them to Linus.
>
> Does anyone else have any pending fixes for 2.6.26?

I don't.  I want/need to do defconfig updates but that can wait if you  
plan on getting this out over the weekend.

- k
