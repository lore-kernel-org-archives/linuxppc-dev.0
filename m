Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A357DE6CA
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 03:56:13 +1000 (EST)
Message-Id: <AF83CB69-4BBA-4AA2-A0BB-46987B9E6995@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <20080523155915.9ABF15AF36@innovsys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH]: Check that TASK_SIZE does not overlap KERNEL_START
Date: Fri, 23 May 2008 12:55:07 -0500
References: <20080523155915.9ABF15AF36@innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 10:59 AM, Rune Torgersen wrote:

> Make sure CONFIG_TASK_SIZE does not overlap CONFIG_KERNEL_START
> This could happen when overriding settings to get 1GB lowmem, and  
> would lead
> to userland mysteriousely hanging.
>
> This setting is only used by PPC32.
>
> Signed-off-by Rune Torgersen <runet@innovsys.com>

you seem to have lost a colon.

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
