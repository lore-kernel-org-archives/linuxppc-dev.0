Message-ID: <39999677.4790E775@the-rileys.net>
Date: Tue, 15 Aug 2000 15:13:59 -0400
From: David Riley <oscar@the-rileys.net>
MIME-Version: 1.0
To: jlquinn@us.ibm.com
CC: tom_gall@vnet.ibm.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Buses
References: <OF2006BA97.98D63D31-ON8525693C.0067A5CE@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


jlquinn@us.ibm.com wrote:

> I thought the 9500/9600 had two PCI buses with 3 slots each?
>
> Jerry Quinn
>

Well, the 9500/9600 have 6 PCI slots, though it's anyone's guess as to how
many are on each bus.  However, the Blue G3's and all G4's as well as the
iBook and any other computer with AGP (including the "fake AGP" fast PCI slot
on the blue G3's) have two PCI busses, since AGP is only a fast PCI bus (with
a few enhancements, but as far as Linux is concerned, it's PCI).  AGP slots
will run compatible PCI cards at 66MHz (though there are certain keys which
prevent insertion unless the card is compatible).  A notable example is
3Dfx's Voodoo2 1000 card (and several other brands) which allow a 66 MHz bus.

On a side note, does anyone know if Linux properly supports the 64-bit PCI
slots in the Blue G3's and G4's?  The only cards I know of that use them are
several SCSI cards and TotalImpact cards.

Thanks,
    David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
