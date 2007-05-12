Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao103.cox.net (fed1rmmtao103.cox.net [68.230.241.43])
	by ozlabs.org (Postfix) with ESMTP id 9BFEADDE44
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 15:04:38 +1000 (EST)
Date: Fri, 11 May 2007 21:48:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Rientjes <rientjes@google.com>
Subject: Re: [patch] powerpc: use __used attribute
Message-ID: <20070512044853.GA9161@smtp.west.cox.net>
References: <alpine.DEB.0.99.0705111628430.16028@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.0.99.0705111628430.16028@chino.kir.corp.google.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 11, 2007 at 04:29:29PM -0700, David Rientjes wrote:

> Use the newly introduced __used attribute instead of the deprecated
> __attribute_used__.  Functionally the same.
> 
> Cc: Tom Rini <trini@kernel.crashing.org>
> Signed-off-by: David Rientjes <rientjes@google.com>

FWIW:
Acked-by: Tom Rini <trini@kernel.crashing.org>

-- 
Tom Rini
