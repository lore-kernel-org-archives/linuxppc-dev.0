Message-ID: <008501c2e9ab$23dcd670$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Stephan Linke" <Stephan.Linke@epygi.de>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <FCEAKDJJAPHPLJFINDAJCELACOAA.Stephan.Linke@epygi.de> <3E70B17E.9090507@embeddededge.com> <004501c2e989$a10a66c0$020120b0@jockeXP> <3E70C88B.70004@embeddededge.com>
Subject: Re: question on howto use invalidate_dcache_range
Date: Thu, 13 Mar 2003 22:54:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > Yes, but you still need to invalidate the buffer before also or invalidate it when the buffer is freed which
> > may be possible if you are using your own buffer mgmt.
>
> Why?

See http://lists.linuxppc.org/linuxppc-embedded/200303/msg00184.html

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
