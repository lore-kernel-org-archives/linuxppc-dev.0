Date: Fri, 21 Jun 2002 07:39:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Trivial cleanup in ocp_uart.c
Message-ID: <20020621143903.GO16052@opus.bloom.county>
References: <20020620073440.GC20689@zax> <20020620155026.GE16052@opus.bloom.county> <20020621005216.GH20689@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020621005216.GH20689@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 21, 2002 at 10:52:16AM +1000, David Gibson wrote:
> On Thu, Jun 20, 2002 at 08:50:26AM -0700, Tom Rini wrote:
> > And I think it can be used, once it gets registered to the ocp_list (and
> > something later accesses it).
>
> *Nothing* scans the ocp_list (well, except ocp_register() and
> ocp_unregister()).  This is why I think ocp_register() is a pointless
> interface.

Yes, but you're also judging an incomplete API.  Armin, would things
like PM support at least be scanning the ocp_list ?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
