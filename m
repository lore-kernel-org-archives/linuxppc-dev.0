Date: Thu, 12 Sep 2002 08:23:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Todd Poynor <tpoynor@mvista.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consistent_free re-revisited
Message-ID: <20020912152352.GE13840@opus.bloom.county>
References: <20020912145146.GD13840@opus.bloom.county> <20020912074907.29155@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020912074907.29155@192.168.4.1>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 12, 2002 at 09:49:07AM +0200, Benjamin Herrenschmidt wrote:
> >> I tend to hate anything that relies on in_interrupt() as they
> >> are other contexts that will have in_interrupt() cleared but still
> >> have the same limitations. Typically, anything on the VM path must
> >> do either GFP_ATOMIC or GFP_NOIO allocations, wether it's running
> >> at interrupt time or not.
> >
> >The problem is that the atomic pool is limited, iirc.
>
> Well, ATOMIC can fail, sure, but if you do GFP_KERNEL within a
> VM code path, then be prepared for deadlocks.

Er, so you're objecting to existing GFP_KERNEL's then?

Or is it too early and I need more coffee? :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
