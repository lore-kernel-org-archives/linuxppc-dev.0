Subject: Re: Caching in the MPC107
From: Adrian Cox <adrian@humboldt.co.uk>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3D7E25F4.4CC00BF8@mvista.com>
References: <1031581408.30396.81.camel@newt>
	<20020910145843.GB797@opus.bloom.county> <1031672735.2686.58.camel@newt>
	<3D7E25F4.4CC00BF8@mvista.com>
Content-Type: text/plain
Date: 10 Sep 2002 18:17:43 +0100
Message-Id: <1031678263.2685.64.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2002-09-10 at 18:03, Mark A. Greer wrote:

> I think I understand what you're saying.  The biggest question that comes to
> my mind, though, is whether this is a problem on many of the other
> hostbridges?  Most of the newer bridges will buffer a cacheline or two.  Is
> this a wider issue than just the 107?

I haven't looked this closely at any other bridges. Many bridges have
buffers to prefetch data during a PCI burst read, but empty the buffers
when the PCI transaction ends. The clever feature of the MPC107 is that
it holds the data to satisfy a later read, and it snoops the 60x bus for
cycles that affect its cache.

- Adrian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
