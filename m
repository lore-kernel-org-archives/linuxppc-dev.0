Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A809DDF19
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 13:11:54 +1000 (EST)
Message-Id: <6BE67DBD-325A-4628-8480-7EA0FE79DBE5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080410103131.f0dcf730.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] 83xx/85xx: Reorganize defconfigs
Date: Wed, 9 Apr 2008 22:11:38 -0500
References: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
	<20080410103131.f0dcf730.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 9, 2008, at 7:31 PM, Stephen Rothwell wrote:
> Hi Kumar,
>
> On Wed, 9 Apr 2008 10:18:06 -0500 (CDT) Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>>
>> Board specific defconfigs are useful, however with the ability to do
>> multi-board defconfigs they aren't needed in the top level configs  
>> directory
>>
>> Move the 83xx/85xx board specific defconfigs to individual  
>> directories under
>> arch/powerpc/configs.
>
> So do we have multi-board defconfigs for 83xx and/or 85xx?

Yeah the are mpc85xx_defconfig and mpc83xx_defconfig.

- k
