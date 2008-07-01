Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABC54DDEDA
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 15:28:28 +1000 (EST)
Message-Id: <39A73A4C-ABF5-4A97-B452-4D7BF131F5CC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <20080520192857.3C3E95AF22@innovsys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] Fix pq2fads irq handling with PREEMPT_RT
Date: Tue, 1 Jul 2008 00:28:01 -0500
References: <20080520192857.3C3E95AF22@innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2008, at 2:28 PM, Rune Torgersen wrote:

> Fix interrupt threading issue on pq2fads when running with  
> CONFIG_PREEMPT_RT
>
> Signed-off-by: Rune Torgersen <runet@innovsys.com>

applied.

- k
