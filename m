Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B7F5AB7160
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:51:01 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0492FDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:51:00 +1000 (EST)
Message-Id: <6567F141-5B17-440E-B052-95E20276B222@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: leon.woestenberg@gmail.com
In-Reply-To: <4a2a9611.06c8100a.49ae.ffff88e4@mx.google.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH v2] Add MSI interrupts to DTS of MPC8315E-RDB
Date: Wed, 10 Jun 2009 20:50:54 -0500
References: <4a2a9611.06c8100a.49ae.ffff88e4@mx.google.com>
Cc: Leon Woestenberg <leon@sidebranch.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 6, 2009, at 11:15 AM, leon.woestenberg@gmail.com wrote:

> The PCIe MSI interrupts are missing from the device tree source, and
> thus were not enabled. This patch adds them.
>
> v2 of the patch fixes inconsistent white space, reported by David  
> Gibson.
>
> Tested to work on MPC8315E-RDB with custom FPGA PCIe device.
>
> Signed-off-by: Leon Woestenberg <leon@sidebranch.com>
> Tested-by: Leon Woestenberg <leon@sidebranch.com>

applied to next.

- k
