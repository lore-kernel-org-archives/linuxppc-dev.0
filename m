Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58A73DDDF2
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 16:19:32 +1100 (EST)
Message-Id: <4C002C21-2823-48CB-B555-125394AAEC60@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: mike zheng <mail4mz@gmail.com>
In-Reply-To: <5c9cd53b0801311128s1801c720pdeda8ee1bdd518e@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Kernel oops in MPC8568MDS BSP
Date: Thu, 31 Jan 2008 23:19:26 -0600
References: <5c9cd53b0801311128s1801c720pdeda8ee1bdd518e@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 31, 2008, at 1:28 PM, mike zheng wrote:

> Hello,
>
> I am using MPC8568MDS BSP on my board, which has same memory map with
> MPC8568MDS board. However I have kernel Ooop at
> free_bootmem_with_active_regions() within do_init_bootmem(). Any idea
> on this issue?

such questions should be asked of the BSP provider.

- k
