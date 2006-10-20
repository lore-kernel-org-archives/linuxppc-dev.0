Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0AA2C67B5B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 16:03:24 +1000 (EST)
Date: Fri, 20 Oct 2006 01:02:49 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] powerpc: Cell timebase bug workaround #3
Message-ID: <20061020010249.24bd3bc8@pb15>
In-Reply-To: <1161322630.10524.136.camel@localhost.localdomain>
References: <1161308840.10524.112.camel@localhost.localdomain>
	<1161319025.10524.134.camel@localhost.localdomain>
	<20061020002409.3c396148@pb15>
	<1161322630.10524.136.camel@localhost.localdomain>
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

On Fri, 20 Oct 2006 15:37:10 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2006-10-20 at 00:24 -0500, Olof Johansson wrote:
> > On Fri, 20 Oct 2006 14:37:05 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Acked-by: Olof Johansson <olof@lixom.net>
> 
> I note that you carefully avoid to hack the vdso and module fixup
> patches :)

Hack or ack? :-)

The module one isn't that hairy, I just didn't look at it during
previous submission so I took it last.

I don't know the VDSO and side effects well enough to review that
patch, so you're on your own there.


-Olof
