Date: Mon, 19 Jan 2004 23:08:20 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040119220820.GA29347@iliana>
References: <20040118144412.GA6897@iliana> <1074503490.4547.52.camel@gaston> <Pine.GSO.4.58.0401191108100.6038@waterleaf.sonytel.be> <1074512479.12326.18.camel@gaston> <20040119120347.GC18112@iliana> <1074548106.12326.26.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074548106.12326.26.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 20, 2004 at 08:35:06AM +1100, Benjamin Herrenschmidt wrote:
>
> > Mmm, should it also be needed to put 0 in the Memory Space and IO space
> > bits of the Command register ?
>
> Probably a good idea, yes.

Mmm.

> > Also, about the Interrupt line, i believe that there is no interrupt
> > used by the northbridge at this time. We were not speaking about the pci
> > config space of the graphic card, but of the bridge, so it should have
> > no influence with DRI or anything else, right ?
>
> Yup.

BTW, xfree86 with voodoo cards and the tdfx driver dies with :

  (EE) TDFX(0): No valid PIO address in PCI config space

But again, this is with the graphic card which should not be touched
here. Tdfxfb is ok though, as is X with the fbdev driver.

Friendly,

Sven Luther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
