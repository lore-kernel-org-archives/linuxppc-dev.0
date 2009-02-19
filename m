Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0572DDDF74
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 03:41:58 +1100 (EST)
Message-Id: <D3F7F9FD-94AD-4FA0-9FDF-DFF92487E5DE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "<dayu@datangmobile.cn>" <dayu@datangmobile.cn>
In-Reply-To: <D728AD1FA2543948B89DE29C5BF4CD0716AF9623@bjmail1.bj.datangmobile.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] fix the interrupt loss problem on powerpc
	IPIC(2.6.25-2.6.28)
Date: Thu, 19 Feb 2009 10:41:40 -0600
References: <D728AD1FA2543948B89DE29C5BF4CD0716AF9623@bjmail1.bj.datangmobile.com>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, leoli@freescale.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 17, 2009, at 11:47 PM, <dayu@datangmobile.cn> <dayu@datangmobile.cn 
 > wrote:

>
> From: Da Yu <dayu@datangmobile.cn>
> Date: Wed, 18 Feb 2009 19:58:20 +0800
> Subject: [PATCH] fix the interrupt loss problem on powerpc IPIC  
> (2.6.25-2.6.28)
>
> Description: The interrupt pending register is write 1 clear.  If  
> there are more than one external interrupts pending at the same  
> time, acking the first interrupt by reading pending register then OR  
> the corresponding bit and write back to pending register will also  
> clear other interrupt pending bits.  That will cause loss of  
> interrupt.
>
> Signed-off-by: Da Yu <dayu@datangmobile.cn>
> ---


applied to next

- k
