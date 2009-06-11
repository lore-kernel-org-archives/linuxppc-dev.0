Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4D5DFB720D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 13:39:30 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0947DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 13:39:29 +1000 (EST)
Message-Id: <2C012660-52A9-4403-8592-FE27A8EA67B0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1244666248-23322-1-git-send-email-ncase@xes-inc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH -next] powerpc/fsl-booke: Enable L1 cache on
	e500v1/e500v2/e500mc CPUs
Date: Wed, 10 Jun 2009 22:39:25 -0500
References: <1244666248-23322-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 10, 2009, at 3:37 PM, Nate Case wrote:

> Some boot loaders may not enable L1 instruction/data cache.  Check if
> data and instruction caches are enabled, and enable them if needed.
>
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
> arch/powerpc/include/asm/reg_booke.h      |    2 +
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |   49 ++++++++++++++++++++ 
> +++++++--
> 2 files changed, 48 insertions(+), 3 deletions(-)

applied to next

- k
