From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Dan Malek" <dan@mvista.com>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: KERNELBASE at 0xa0000000
Date: Mon, 26 Feb 2001 16:51:57 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMIEGLCPAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3A9A7080.995B7E00@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Stefano Coluccini wrote:
> >
> > Hi,
> >   anybody knows why in the MCPN765 port KERNELBASE is at
> 0xa0000000 instead
> > of 0xc0000000 ?
>
> Yep.  It was a quick hack to get a system with 1GByte of memory
> working.  It works fine with all other memory configurations as well.

Thanks a lot for the reply.
I have hoped it was more platform-dependent because I have a MVME5100 (that
is, I think, a MCPN765 with a PCI-VME bridge) and with KERNELBASE at
0xa0000000 doesn't work (in head.S the kernel doesn't recognize that it is
running at 0 and it try to relocate itself).
Do you think that this is a warning of a more complicated problem ?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
