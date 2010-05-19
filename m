Return-Path: <horms@verge.net.au>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id 8525EB7D71
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 May 2010 10:45:31 +1000 (EST)
Date: Wed, 19 May 2010 09:22:56 +0900
From: Simon Horman <horms@verge.net.au>
To: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [patch] ppc: Fix gamecube build
Message-ID: <20100519002255.GD8536@verge.net.au>
References: <20100513152519.GA4143@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100513152519.GA4143@verge.net.au>
Cc: Maxim Uvarov <muvarov@gmail.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 14, 2010 at 12:25:19AM +0900, Simon Horman wrote:
> This fixes the kexec-build on ppc32 when
> the --game-cube option is supplied to ./configure.
> It seems to have bit-rotted a little.
> 
> Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> Cc: Maxim Uvarov <muvarov@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

I have gone ahead and applied this change.
