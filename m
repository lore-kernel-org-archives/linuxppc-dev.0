Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0574B68802
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Dec 2005 11:48:07 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrei Warkentin <andrey.warkentin@gmail.com>
In-Reply-To: <61AB94A8-8912-4699-A32A-70AC1155BA34@dataarmor.net>
References: <61AB94A8-8912-4699-A32A-70AC1155BA34@dataarmor.net>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 11:43:26 +1100
Message-Id: <1134780206.6102.18.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Typo in arch/ppc/kernel/head.S?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-12-16 at 01:35 -0600, Andrei Warkentin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Hello,
> 
> I was looking at head.S under arch/ppc/kernel and it seems the  
> comment above ".globl __start" is slightly off. Under
> the PMAC section it mentions that .text/.data/.bss are loaded @ 0x0,  
> while they could be pretty much loaded anywhere but 0x0, with OF
> exception vectors being there. Am I understanding this correctly?

The comment is pre-historical :) The zImage used to put the kernel at 0
and BootX puts it there too, but the former has been changed. The kernel
can indeed be loaded pretty much anywhere.

Ben.
