Message-ID: <004501c2e989$a10a66c0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>,
	"Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <FCEAKDJJAPHPLJFINDAJCELACOAA.Stephan.Linke@epygi.de> <3E70B17E.9090507@embeddededge.com>
Subject: Re: question on howto use invalidate_dcache_range
Date: Thu, 13 Mar 2003 18:54:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Stephan Linke wrote:
>
> > After all is it realy neccessary to use invalidate_dcache range before giving the transmit buffer to the DMA?
>
> The logically correct cache operation is to invalidate an incoming buffer
> after the DMA has completed

Yes, but you still need to invalidate the buffer before also or invalidate it when the buffer is freed which
may be possible if you are using your own buffer mgmt.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
