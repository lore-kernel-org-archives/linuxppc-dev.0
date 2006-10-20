Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9CF2367B9E
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 12:00:44 +1000 (EST)
Date: Thu, 19 Oct 2006 21:00:08 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc: consolidate feature fixup code
Message-ID: <20061019210008.2e5fa2c4@pb15>
In-Reply-To: <1161308835.10524.108.camel@localhost.localdomain>
References: <1161308835.10524.108.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Oct 2006 11:47:15 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> There are currently two versions of the functions for applying the
> feature fixups, one for CPU features and one for firmware features. In
> addition, they are both in assembly and with separate implementations
> for 32 and 64 bits. identify_cpu() is also implemented in assembly and
> separately for 32 and 64 bits.
> 
> This patch replaces them with a pair of C functions. The call sites are
> slightly moved on ppc64 as well to be called from C instead of from
> assembly, though it's a very small change, and thus shouldn't cause any
> problem.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Olof Johansson <olof@lixom.net>
