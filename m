Date: Mon, 26 Feb 2001 11:07:45 -0500
From: =?ISO-8859-1?Q?S=E9bastien_C=F4t=E9?= <scote1@matrox.com>
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: Dan Malek <dan@mvista.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: KERNELBASE at 0xa0000000
Message-ID: <20010226110745.A1229@dyn-52-73.matrox.com>
References: <3A9A7080.995B7E00@mvista.com> <NDBBIFIMCKPOADMAJOKMIEGLCPAA.s.coluccini@caen.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <NDBBIFIMCKPOADMAJOKMIEGLCPAA.s.coluccini@caen.it>; from s.coluccini@caen.it on Mon, Feb 26, 2001 at 10:51:57 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 2001.02.26 10:51:57 -0500 Stefano Coluccini wrote:
> I have hoped it was more platform-dependent because I have a MVME5100
> (that
> is, I think, a MCPN765 with a PCI-VME bridge) and with KERNELBASE at
> 0xa0000000 doesn't work (in head.S the kernel doesn't recognize that it
> is
> running at 0 and it try to relocate itself).
> Do you think that this is a warning of a more complicated problem ?

I think that's what happened when I changed KERNELBASE but not KERNELLOAD.
Try changing both (if it's not already done).

Sébastien Côté


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
