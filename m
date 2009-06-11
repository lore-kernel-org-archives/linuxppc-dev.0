Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 75023B7221
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 13:48:11 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC38BDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 13:48:10 +1000 (EST)
Message-Id: <A7E846FC-2D42-4E82-AE08-EDE30E6AFF54@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1244499462-18719-1-git-send-email-ncase@xes-inc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/boot: cuboot: Fix up ethernet3 MAC address on
	MPC85xx
Date: Wed, 10 Jun 2009 22:48:00 -0500
References: <1244499462-18719-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 8, 2009, at 5:17 PM, Nate Case wrote:

> MPC85xx platforms do support 4 ethernet ports, so make sure the boot
> wrapper fixes up all of them in the fdt.
>
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
> arch/powerpc/boot/cuboot-85xx.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)

applied (updated commit message) to next

- k
