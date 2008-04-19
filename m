Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 762B6DDDFD
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 00:58:43 +1000 (EST)
Message-Id: <670559C8-CDD2-42A3-BF8A-E5521E5DC411@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <633e3f1106fd888b93a0f18c73449fd86054cc05.1208559659.git.jgarzik@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 04/15] [PPC] minor irq handler cleanups
Date: Sat, 19 Apr 2008 09:57:55 -0500
References: <d7afbccda111e535bb14ad8082b208c7a2cd9833.1208559659.git.jgarzik@redhat.com>
	<633e3f1106fd888b93a0f18c73449fd86054cc05.1208559659.git.jgarzik@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 18, 2008, at 6:22 PM, Jeff Garzik wrote:
> - whitespace cleanups
>
> - remove pointless prototype (uses always follow func implementation)
>
> - 'irq' argument is often used purely as a local variable.  rename
>  argument to 'dummy' and define 'irq' as local to make this plain.
>
> - remove pointless casts from void*
>
> This change's main purpose is to prepare for the patchset in
> jgarzik/misc-2.6.git#irq-remove, that explores removal of the
> never-used 'irq' argument in each interrupt handler.
>
> Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

arch/ppc is pretty much left for dead at this point.  I'm guessing we  
will end up removing it 2.6.27 if we follow through with our plans of  
killing it this summer.

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
