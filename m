Date: Mon, 27 May 2002 09:23:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
Message-ID: <20020527162323.GB32718@opus.bloom.county>
References: <20020527040330.GH16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020527040330.GH16537@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 27, 2002 at 02:03:30PM +1000, David Gibson wrote:

> I realise that logically the OCP enet driver, and the
> consistent_sync() has nothing to do with PCI.  However using the pci.h
> constants seems a better approach than defining new constants with the
> same values, when the switch in consistent_sync() explicitly checks
> against the PCI constants.
>
> In the longer term consistent_sync() itself should be changed not to
> reference the PCI constants - in fact the PCI constants should
> probably be moved and renamed since they have no inherent connection
> with PCI at all.

At this point I think I should give my 2 cents, so...

I think we should keep ocp-dma.h around for now (2.4.x timeframe) and
change consistent_sync() to not check for the PCI versions (which I
believe happened just because it's a cut&paste&fix of the ARM code) and
for 2.5 hope that a more general fix comes out..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
