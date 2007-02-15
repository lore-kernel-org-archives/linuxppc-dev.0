Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A077DDD07
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 12:42:43 +1100 (EST)
In-Reply-To: <1712A11E-2F9F-441E-97E2-6FE82ED5A539@kernel.crashing.org>
References: <11713852392294-git-send-email-timur@freescale.com>
	<1712A11E-2F9F-441E-97E2-6FE82ED5A539@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e5c7f884689875fe81080aaefd16f2e6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
Date: Thu, 15 Feb 2007 02:42:38 +0100
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Is there some harm is having them set in the .dts?
>
> I can see 'linux,boot-cpu' may vary on a SMP, but the majority
> of .dts's are for uniproc's

The way this is handled in the OF binding, only multi-processor
systems are required to explicitly state their boot CPU (in
/chosen/cpu).  It's quite silly to require this for single
CPU systems.


Segher
