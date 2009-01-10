Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 299B9DE4EE
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 10:30:26 +1100 (EST)
Subject: Re: [PATCH] powerpc: rework dma-noncoherent to use generic
	vmap/vunmap functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ilya Yanok <yanok@emcraft.com>
In-Reply-To: <1231505915-16082-1-git-send-email-yanok@emcraft.com>
References: <1231505915-16082-1-git-send-email-yanok@emcraft.com>
Content-Type: text/plain
Date: Sun, 11 Jan 2009 10:30:02 +1100
Message-Id: <1231630202.2142.90.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-01-09 at 15:58 +0300, Ilya Yanok wrote:
> This patch rewrites consistent dma allocations support to use vmalloc
> layer to allocate virtual memory space from vmalloc pool and get rid
> of CONFIG_CONSISTENT_{START,SIZE}.

Ah good, I like that. I haven't reviewed in details yet but that's the
right approach. I'll have a closer look hopefully tomorrow.

I seems too late for .29 though... 

Cheers,
Ben.
