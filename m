From: Jim Thompson <jim@SmallWorks.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15229.53478.867522.930647@zaphod.smallworks.com>
Date: Fri, 17 Aug 2001 21:20:22 -0500
To: pdecker@wavewireless.com
Cc: linuxppc-embedded@lists.linuxppc.org, a16975@motorola.com,
	mlocke@mvista.com, trini@kernel.crashing.org
Subject: RE: Is there a PCI based 802.11b device driver for ppc linux?
In-Reply-To: <0E97488D670BD411B8BD00C0F03BDF64AD6593@SPEEDCOM3>
References: <0E97488D670BD411B8BD00C0F03BDF64AD6593@SPEEDCOM3>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Philip Decker writes:
 >
 > If Liu plans to use a mini-PCI 802.11b radio, and that radio is based on
 > Prism 2.5, and it uses the ISL3874 MAC/BBP (which interfaces directly to the
 > PCI Bus), then there is no Linux driver yet (that I'm aware of).

Working on it.  (Yes, on PowerPC.)

 > On the other hand, if his mini PCI radio is Prism II, or Prism 2.5 but using
 > the ISL3873 MAC/BBP, then that radio contains a PCI to PCMCIA bridge and the
 > existing Linux drivers will work.
 >
 > I don't know about Linux drivers for Agere/Lucent Orinoco/WaveLAN mini-PCI
 > radio.
 >
 > If Liu's question had nothing to do with mini-PCI radios then, in the
 > immortal words of E. Litella, "Never mind".

(non-mini) PCI Prism 2.5 cards exist too.  :-)

Jim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
