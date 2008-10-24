Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 650B1DDDE0
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 04:40:47 +1100 (EST)
Message-ID: <4902086E.6030900@freescale.com>
Date: Fri, 24 Oct 2008 12:39:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: default IRQ affinity change in v2.6.27 (breaking several SMP
	PPC	based systems)
References: <4E3CD4D5-FC1B-40BF-A776-C612B95806B8@kernel.crashing.org>	<4901E6FB.4070200@redhat.com>	<36A821E7-7F37-42AF-9A05-7205FCBF89EE@kernel.crashing.org>	<4901F31E.9040007@redhat.com>
	<5967704E-0117-46B8-8505-6A002502C38C@kernel.crashing.org>
In-Reply-To: <5967704E-0117-46B8-8505-6A002502C38C@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: LinuxPPC-dev list <linuxppc-dev@ozlabs.org>, tglx@linutronix.de,
	Chris Snook <csnook@redhat.com>,
	linux-kernel Kernel <linux-kernel@vger.kernel.org>, maxk@qualcomm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> So why not just have x86 startup code set irq_default_affinity = 
> CPU_MASK_ALL than?

That doesn't really solve the problem, as a user could still manually 
set an invalid affinity.  The MPIC driver should reduce the affinity 
itself to what the hardware can handle.

-Scott
