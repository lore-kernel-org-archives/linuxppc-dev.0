From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Matt Porter" <porter@cox.net>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: R: MCPN765 - 7410 - Illegal instruction
Date: Thu, 19 Sep 2002 14:41:04 +0200
Message-ID: <NDBBIFIMCKPOADMAJOKMIEFJENAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020919055503.A26648@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you very much !!!
I always forget the ENV command ...


> -----Messaggio originale-----
> Da: Matt Porter [mailto:porter@cox.net]
> Inviato: giovedi 19 settembre 2002 14.55
> A: Stefano Coluccini
> Cc: Linuxppc-Embedded
> Oggetto: Re: MCPN765 - 7410 - Illegal instruction
>
>
> On Thu, Sep 19, 2002 at 02:24:28PM +0200, Stefano Coluccini wrote:
> >
> > Hi all,
> >   I'm trying to run the linux kernel (2.4.18-pre3) on a Motorola MCPN765
> > with the 7410 processor, but immediately after the tftp
> transfer (with nbo)
> > the kernel stops with an illegal instruction. I've used
> correctly the same
> > kernel with a MCPN765 with the 750 processor for a long time.
> > Anyone of you knows the origin of the problem ?
>
> Yes, when you got your new MCPN765 board you forgot to enable the
> Network PReP boot option in 'ENV'.
>
> Regards,
> --
> Matt Porter
> porter@cox.net
> This is Linux Country. On a quiet night, you can hear Windows reboot.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
