Date: Sun, 4 Jul 2004 20:05:07 +0200
To: Sylvain Munaut <tnt@246tnt.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Andy Fleming <afleming@freescale.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IRQ Level / Edge
Message-ID: <20040704180507.GA11918@pegasos>
References: <40E5D609.6090201@246tNt.com> <DE336CD5-CC79-11D8-BA44-000393C30512@freescale.com> <20040703164216.GA22998@pegasos> <40E83EFD.8000309@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <40E83EFD.8000309@246tNt.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 04, 2004 at 07:31:41PM +0200, Sylvain Munaut wrote:
>
> >
> > Err, i suppose the interesting bit is not how the board designer
> > will know wheter the interrupt is edge or level, but how the kernel
> > running on the board is able to detect it ?
> >
> > Friendly,
>
>
> Well, the kernel doesn't detect it. You have to tell him !
> That's why I asked, because in the interrupt controller code, you have
> to set it in the irq_desc[i] structure.

Mmm, i suppose the firmware would know about it, and it should be
possible to read it from there ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
