Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B009367B56
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 15:37:20 +1000 (EST)
Subject: Re: [PATCH 5/5] powerpc: Cell timebase bug workaround #3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061020002409.3c396148@pb15>
References: <1161308840.10524.112.camel@localhost.localdomain>
	<1161319025.10524.134.camel@localhost.localdomain>
	<20061020002409.3c396148@pb15>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 15:37:10 +1000
Message-Id: <1161322630.10524.136.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Fri, 2006-10-20 at 00:24 -0500, Olof Johansson wrote:
> On Fri, 20 Oct 2006 14:37:05 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Acked-by: Olof Johansson <olof@lixom.net>

I note that you carefully avoid to hack the vdso and module fixup
patches :)

Ben.
