Date: Wed, 17 Oct 2001 07:26:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Ralph Blach <rcblach@raleigh.ibm.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: pci_dma_sync_single
Message-ID: <20011017072636.F28679@cpe-24-221-152-185.az.sprintbbd.net>
References: <15308.8725.416230.867981@cargo.ozlabs.ibm.com> <3BCC324C.9EE9C105@raleigh.ibm.com> <15308.58189.136492.881833@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15308.58189.136492.881833@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 17, 2001 at 11:47:56AM +1000, Paul Mackerras wrote:
>
> Ralph Blach writes:
>
> > This would probably work, except on Book E platforms, where DR off
> > simpley gets you another translaton and NOT
> > a physical address.
>
> We don't support any Book E platforms at the moment anyway.  When we
> do this will be one of the issues we have to address.

Eh?  Aren't the 403 and 405 both Book E?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
