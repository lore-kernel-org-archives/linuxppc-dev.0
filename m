Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2EBE4B7497
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 13:16:48 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7594CDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 13:16:47 +1000 (EST)
Message-Id: <7762D98B-40F7-4CC1-A2FD-4EE7C6D229AA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1244749381-17429-5-git-send-email-ncase@xes-inc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH -next 4/4] powerpc/bootwrapper: Custom build options for
	XPedite52xx targets
Date: Mon, 15 Jun 2009 22:16:38 -0500
References: <1244749381-17429-1-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-2-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-3-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-4-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-5-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 11, 2009, at 2:43 PM, Nate Case wrote:

> Some XPedite52xx boards have a legacy boot loader requiring some  
> special
> care in the boot wrapper.  The use of cuboot-85xx is needed to fix
> up embedded device trees, and a custom link address is specified to
> accommodate the boot loader and larger kernel image sizes used on X-ES
> MPC85xx platforms.
>
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
> arch/powerpc/boot/wrapper |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)


applied to next

- k
