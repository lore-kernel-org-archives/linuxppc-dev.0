Message-ID: <0E97488D670BD411B8BD00C0F03BDF64AD6593@SPEEDCOM3>
From: Philip Decker <pdecker@wavewireless.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Liu HongXun-a16975 <a16975@motorola.com>,
	"'Matthew Locke'" <mlocke@mvista.com>,
	Tom Rini <trini@kernel.crashing.org>
Subject: RE: Is there a PCI based 802.11b device driver for ppc linux?
Date: Fri, 17 Aug 2001 17:53:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If Liu plans to use a mini-PCI 802.11b radio, and that radio is based on
Prism 2.5, and it uses the ISL3874 MAC/BBP (which interfaces directly to the
PCI Bus), then there is no Linux driver yet (that I'm aware of).

On the other hand, if his mini PCI radio is Prism II, or Prism 2.5 but using
the ISL3873 MAC/BBP, then that radio contains a PCI to PCMCIA bridge and the
existing Linux drivers will work.

I don't know about Linux drivers for Agere/Lucent Orinoco/WaveLAN mini-PCI
radio.

If Liu's question had nothing to do with mini-PCI radios then, in the
immortal words of E. Litella, "Never mind".


PJD

> -----Original Message-----
> From: Matthew Locke [mailto:mlocke@mvista.com]
> Sent: Friday, 17 August, 2001 4:45 PM
> To: Tom Rini
> Cc: Liu HongXun-a16975; linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Is there a PCI based 802.11b device driver for ppc linux?
>
>
>
> Tom Rini wrote:
>
> > On Fri, Aug 17, 2001 at 11:11:28AM +0800, Liu HongXun-a16975 wrote:
> >
> >> Hi, all,
> >> Our customized ppc based board only has PCI interface. I
> wonder if there is a PCI based 802.11b device driver for ppc linux?
> >
> >
> > Well, it depends on the chipset.  And is it a PCI one or a
> pcmcia one in a
> > pcmcia pci card.  I think some of the prism II and whatnot
> based cards work.
> > Take a look in drivers/net/wireless.
> >
>
> Both the prism II and Cisco PCI cards have device drivers.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
