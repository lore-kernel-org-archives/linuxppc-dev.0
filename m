Date: Thu, 17 Jun 2004 09:16:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC][PATCH 3/9] Support for old IBM PReP boxes
Message-ID: <20040617161616.GK24479@smtp.west.cox.net>
References: <1831.80.7.99.14.1086886556.squirrel@www.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1831.80.7.99.14.1086886556.squirrel@www.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 10, 2004 at 05:55:56PM +0100, Leigh Brown wrote:

>
> This patch adds a function residual_pcidev_irq() which finds out
> from the residual data which IRQ the given PCI device should use.
> The interesting part about this patch is the changes I made to
> prep_pcibios_fixup().  The old code was more than a little
> opaque so I tried to change it to make it a bit clearer.  I'd
> definitely be pleased if someone could cast their eyes over
> that bit.

Is this jsut a "Residual Data is Good" type change, or does it fix some
set of IBM machines?  I ask since residual data on Motorola PRePs can be
incorrect, iirc.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
