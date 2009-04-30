Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6242F4F8D4
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 23:12:55 +1000 (EST)
Message-Id: <79EA737C-47A7-4959-BCAC-022142D978C3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Deepak Gaur <dgaur@cdotd.ernet.in>
In-Reply-To: <20090430065054.M32339@cdotd.ernet.in>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [2.6.29] MPC8560 Powerpc Port linux-2.6.29 
Date: Thu, 30 Apr 2009 08:12:43 -0500
References: <20090429110648.M98089@cdotd.ernet.in>
	<20090430032937.M98987@cdotd.ernet.in>
	<20090430065054.M32339@cdotd.ernet.in>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2009, at 1:51 AM, Deepak Gaur wrote:

> Hello all
>
> I have a custom board with MPC8560 and 1GB DDR SDRAM. I am trying to  
> port linux - 2.6.29
> on this board. The U-BOOT is already ported on the board and is  
> working.
>
> The OS uImage is stored in code flash at address 0xe0000000 and OS  
> is booted by U-BOOT
> While OS do boot but after some prints weired errors start showing  
> up. Rootfile system
> is NFS based . I have checked the register values with Hardware  
> person using Trace32
> emulator and they are as expected.

1. what happens if you boot with mem=256M or something like that on  
the command line?
2. do you have CONFIG_HIGHMEM enabled?

- k
