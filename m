Date: Sun, 19 Aug 2001 18:42:05 -0400 (EDT)
From: "Mark S. Mathews" <mark@linux-wlan.com>
To: Jim Thompson <jim@SmallWorks.COM>
Cc: pdecker@wavewireless.com, linuxppc-embedded@lists.linuxppc.org,
	a16975@motorola.com, mlocke@mvista.com, trini@kernel.crashing.org
Subject: RE: Is there a PCI based 802.11b device driver for ppc linux?
In-Reply-To: <15229.53478.867522.930647@zaphod.smallworks.com>
Message-ID: <Pine.LNX.4.21.0108191839450.10988-100000@chef.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ISL3874 mini-PCI support is in testing and will be released in
linux-wlan-ng later this week.  We're not currently testing on PPC but the
existing code does run on PPC.  Hopefully the mini-PCI support won't break
anything.

-Mark

On Fri, 17 Aug 2001, Jim Thompson wrote:

>
> Philip Decker writes:
>  >
>  > If Liu plans to use a mini-PCI 802.11b radio, and that radio is based on
>  > Prism 2.5, and it uses the ISL3874 MAC/BBP (which interfaces directly to the
>  > PCI Bus), then there is no Linux driver yet (that I'm aware of).
>
> Working on it.  (Yes, on PowerPC.)
>
>  > On the other hand, if his mini PCI radio is Prism II, or Prism 2.5 but using
>  > the ISL3873 MAC/BBP, then that radio contains a PCI to PCMCIA bridge and the
>  > existing Linux drivers will work.
>  >
>  > I don't know about Linux drivers for Agere/Lucent Orinoco/WaveLAN mini-PCI
>  > radio.
>  >
>  > If Liu's question had nothing to do with mini-PCI radios then, in the
>  > immortal words of E. Litella, "Never mind".
>
> (non-mini) PCI Prism 2.5 cards exist too.  :-)
>
> Jim
>
>

--

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
715-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
