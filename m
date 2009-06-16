Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CFFE8B714B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 13:16:37 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21DC5DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 13:16:36 +1000 (EST)
Message-Id: <F87D9CE0-D3F9-4F8B-B5C3-73FA69850268@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1244749381-17429-2-git-send-email-ncase@xes-inc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH -next 1/4] powerpc/85xx: Add platform support for X-ES
	MPC85xx boards
Date: Mon, 15 Jun 2009 22:16:22 -0500
References: <1244749381-17429-1-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-2-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 11, 2009, at 2:42 PM, Nate Case wrote:

> Add support for X-ES single-board computers based on the Freescale
> MPC85xx processors.
>
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig       |   10 +
> arch/powerpc/platforms/85xx/Makefile      |    1 +
> arch/powerpc/platforms/85xx/xes_mpc85xx.c |  282 ++++++++++++++++++++ 
> +++++++++
> 3 files changed, 293 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/platforms/85xx/xes_mpc85xx.c


applied to next

- k
