Subject: Re: [PATCH] Fixup for DEC 21154 bridge to allow CardBus support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Roskin <proski@gnu.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.58.0405240227210.3182@portland.hansa.lan>
References: <Pine.LNX.4.58.0405231954120.10093@portland.hansa.lan>
	 <1085363158.15315.11.camel@gaston>
	 <Pine.LNX.4.58.0405240031200.2676@portland.hansa.lan>
	 <1085376973.14969.47.camel@gaston>
	 <Pine.LNX.4.58.0405240227210.3182@portland.hansa.lan>
Content-Type: text/plain
Message-Id: <1085381211.24948.60.camel@gaston>
Mime-Version: 1.0
Date: Mon, 24 May 2004 16:46:52 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I guess we don't understand each other.  I thought you didn't like that I
> the PCI bridge would handle all buses from 1 to 255.  I assumed that you
> meant that some of those buses can be used by some other PCI bridges.  I
> assumed that if the P2P bridge is behind the main PCI bridge, the buses
> handled by the P2P bridge would be a subset of the buses handles by the
> the main PCI bridge.

You are right, I was on crack

> I assure you that every CardBus bridge would only use 4 buses.  It won't
> use all 253 buses.
>
> Anyway, you know PowerPC architecture much better.  I might be missing
> something obvious.  After all, the upper bus range is just a number.
> Adjust it in any direction if you want.
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
