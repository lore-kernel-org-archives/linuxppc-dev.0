Date: Fri, 11 Oct 2002 12:41:43 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Radeon 7000 in 9500 - which slot?
Message-ID: <20021011124143.A16886@suse.de>
References: <20021011092019.A1374@suse.de> <20021011100935.10178@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021011100935.10178@192.168.4.1>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


begin  On Fri, Oct 11, Benjamin Herrenschmidt wrote:

> >> Where ? Can you elaborate ? inside radeonfb ? pci_device_to_OF_node
> >> should not return NULL, I though I fixed that...
> >
> >Look in the first few lines of
> >arch/ppc/kernel/pci.c:pci_device_to_OF_node()
> >lots of return NULL; there ;)
> >
> >OF doesnt init the card in some of the slots -> no OF properties.
>
> Ah, you mean no OF properties at all ? ok, that's bad. I'll
> make sure radeonfb is robust enough. The problem is that without
> those properties, we won't know the card's clock, so we'll have
> to guess it, that may not work.

Yes, I did not say it works in this config, but it does not oops at
least ;)

Gruss Olaf

--
 $ man Notes

BUGS
       You need http://www.sauerstoff-laden.de/ soon...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
