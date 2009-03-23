Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D82D3DDF71
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 00:50:14 +1100 (EST)
Message-Id: <26C519AB-7936-4C66-A229-EABE25F7055E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1237815974-21282-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/mm: Fix Respect _PAGE_COHERENT on classic ppc32
	SW TLB load machines
Date: Mon, 23 Mar 2009 08:48:51 -0500
References: <1237815974-21282-1-git-send-email-galak@kernel.crashing.org>
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 23, 2009, at 8:46 AM, Kumar Gala wrote:

> Grant picked up the wrong version of "Respect _PAGE_COHERENT on  
> classic
> ppc32 SW" (commit a4bd6a93c3f14691c8a29e53eb04dc734b27f0db)
>
> It was missing the code to actually deal with the fixup of
> _PAGE_COHERENT based on the CPU feature.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/kernel/head_32.S |    9 +++++++++
> 1 files changed, 9 insertions(+), 0 deletions(-)

I sent a pull request.  This needs to applied for .29

- k
