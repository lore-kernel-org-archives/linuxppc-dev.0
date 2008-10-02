Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0864CDDF01
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 22:53:06 +1000 (EST)
Message-Id: <2AF4947A-B0E5-4530-9240-55C94A73E9FC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
In-Reply-To: <1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: dtb and purgatory support for ppc32
Date: Thu, 2 Oct 2008 07:52:37 -0500
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Siewior <bigeasy@linutronix.de>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 1, 2008, at 4:20 PM, Sebastian Andrzej Siewior wrote:

> From: Sebastian Siewior <bigeasy@linutronix.de>
>
> Some code dtb scanning & filling has been borrowed from ppc64.
> The old behavior is still available if compiled with GameCube,
> other PowerPC platform use the can purgatory and specify a new
> dtb.
> The purgatory is disabled because somehting is wrong and I dunno
> the reason. Booting a self containd cuImage (incl. dtb / wiuthout
> the need for a bd sturct) can be booted.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> kexec/arch/ppc/Makefile            |    1 +
> kexec/arch/ppc/kexec-elf-ppc.c     |  167 ++++++++++----
> kexec/arch/ppc/kexec-elf-rel-ppc.c |    4 +
> kexec/arch/ppc/kexec-ppc.c         |  469 +++++++++++++++++++++++++++ 
> ++++++++-
> purgatory/arch/ppc/Makefile        |    1 +
> purgatory/arch/ppc/purgatory-ppc.c |    4 +
> purgatory/arch/ppc/v2wrap.S        |   54 ++++
> 7 files changed, 652 insertions(+), 48 deletions(-)
> create mode 100644 purgatory/arch/ppc/v2wrap.S

I think I might have realized some of my confusion.. is this patch to  
the kernel or to some kexec tool?   If its to the kernel I don't  
answer at all.  If its to some kexec tool than that wasn't clear at all.

- k
