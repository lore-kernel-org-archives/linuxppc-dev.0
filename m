Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68D02DDDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 17:19:23 +1100 (EST)
Message-Id: <EC566605-6890-4983-8700-3B15C9EFC1C5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <ABF87B0B6A38C0458E319AC973ED68AEBD0677@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 4/6] Add multi mport support.
Date: Thu, 31 Jan 2008 00:15:21 -0600
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<12016890773706-git-send-email-wei.zhang@freescale.com>
	<AF4B8466-C1CE-4FFB-8341-4BFC1CB76116@kernel.crashing.org>
	<ABF87B0B6A38C0458E319AC973ED68AEBD0677@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2008, at 11:57 PM, Zhang Wei wrote:

>
>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>
>> On Jan 30, 2008, at 4:30 AM, Zhang Wei wrote:
>>
>>> Change lots of static variable to mport private. And add
>> mport to some
>>> function declaration.
>>
>> Can you explain this patch further.  Its not clear exactly from this
>> commit message why we are doing this.
>>
>> - k
>
> Sorry about I have a little hurry about it.
>
> The original RapidIO driver suppose there is only one mpc85xx RIO
> controller
> in system. So, some data structures are defined as mpc85xx_rio global,
> such as 'regs_win', 'dbell_ring', 'msg_tx_ring'. Now, I changed them  
> to
> mport's private members. And you can define multi RIO OF-nodes in dts
> file
> for multi RapidIO controller in one processor, such as PCI/PCI-Ex host
> controllers
> in Freescale's silicon. And the mport operation function declaration
> should be changed
> to know which RapidIO controller is target.

thanks, this makes a lot of sense and now reviewing the patch will  
make some sense to me :)

- k
