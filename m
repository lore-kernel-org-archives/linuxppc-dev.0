Date: Thu, 13 Jun 2002 13:58:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Eugene Surovegin <ebs@innocent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020613205824.GX13541@opus.bloom.county>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 12:28:29PM -0700, Eugene Surovegin wrote:

> This is the patch which allows pci_alloc_consistent (and consistent_alloc)
> to be called from an interrupt context.
> It's the required behavior according to Documentation/DMA-mapping.txt.

It looks okay.  But I don't see (immediatly) why the change to
pci_alloc_consistent was needed as well.  Can you (or Dan Malek, if
you're reading this..) explain?

But aside from that, it looks good and the next step would be to try and
get the generic changes into 2.5 (and the 2.4.20-pre1, 2.4.19 is more or
less frozen, esp for a change like this I suspect).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
