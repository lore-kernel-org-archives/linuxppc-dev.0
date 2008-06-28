Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 836F0DDDE9
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 01:07:35 +1000 (EST)
Message-Id: <08A80326-6E58-43BC-9AB1-3136A0285A84@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <200806280851.35417.bart.vanassche@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 2.6.25.9] Make sure that include/asm-powerpc/spinlock.h
	does not trigger compilation warnings
Date: Sat, 28 Jun 2008 10:07:26 -0500
References: <200806280851.35417.bart.vanassche@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 28, 2008, at 1:51 AM, Bart Van Assche wrote:

> When compiling kernel modules for ppc that include <linux/ 
> spinlock.h>, gcc
> prints a warning message every time it encounters a function  
> declaration where
> the inline keyword appears after the return type. The patch below  
> makes sure
> that the order of the inline keyword and the return type is as gcc  
> expects it.
> Additionally, the __inline__ keyword is replaced by inline, as  
> checkpatch
> expects.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@gmail.com>

what version of gcc and what config are you building for?

- k
