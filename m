Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040119120347.GC18112@iliana>
References: <20040118144412.GA6897@iliana> <1074503490.4547.52.camel@gaston>
	 <Pine.GSO.4.58.0401191108100.6038@waterleaf.sonytel.be>
	 <1074512479.12326.18.camel@gaston>  <20040119120347.GC18112@iliana>
Content-Type: text/plain
Message-Id: <1074548106.12326.26.camel@gaston>
Mime-Version: 1.0
Date: Tue, 20 Jan 2004 08:35:06 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Mmm, should it also be needed to put 0 in the Memory Space and IO space
> bits of the Command register ?

Probably a good idea, yes.

> Also, about the Interrupt line, i believe that there is no interrupt
> used by the northbridge at this time. We were not speaking about the pci
> config space of the graphic card, but of the bridge, so it should have
> no influence with DRI or anything else, right ?

Yup.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
