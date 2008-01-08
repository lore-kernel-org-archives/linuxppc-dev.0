Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C28ADDF1E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 17:23:23 +1100 (EST)
Message-Id: <CC561FA6-0590-4BC0-B42B-7EE1B379CE8E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <11996296134110-git-send-email-Yu.Liu@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Fix remainder calculating bug in single floating point
	division
Date: Tue, 8 Jan 2008 00:22:25 -0600
References: <11996296134110-git-send-email-Yu.Liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 6, 2008, at 8:26 AM, Liu Yu wrote:

> This bug exists in the emulation of floating point division for  
> powerpc.
>
> The original code cannot count the remainder correctly.
> I can provide a test case to trigger this bug.
> When use fdiv to count 1.1754941e-38f / 0.9999999f,
> the result is expected to be 1.175494e-38f,
> but we will get 1.174921e-38f in the original case.
>
> Comments are always welcomed!

can you provide the test case that shows the error.

- k
