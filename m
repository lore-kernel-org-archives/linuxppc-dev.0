Return-Path: <tglx@linutronix.de>
Received: from debian.tglx.de (unknown [213.239.205.147])
	by ozlabs.org (Postfix) with ESMTP id 83AC62BF0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 02:18:13 +1100 (EST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <366A345A-4EAC-11D9-9441-000393DBC2E8@freescale.com>
References: <1103122166.3406.174.camel@tglx.tec.linutronix.de>
	<366A345A-4EAC-11D9-9441-000393DBC2E8@freescale.com>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 16:18:10 +0100
Message-Id: <1103123890.3406.180.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Compile 6xx specific code only for 6xx machines
Reply-To: tglx@linutronix.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2004-12-15 at 09:15 -0600, Kumar Gala wrote:
> One reason for this is that we dont have boot/common code for e500.  Up 
> to this point we've been using uImage's which causes code in 
> boot/common not to get built.
> 
> Maybe someone will be motivated to right e500/85xx boot/common code :)
> 
> - kumar

By adding this fix I can use the code in boot/simple. It works nice :)

tglx
