From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>,
	"Pantelis Antoniou" <panto@intracom.gr>
Cc: "Tom Rini" <trini@kernel.crashing.org>,
	"Kumar Gala" <kumar.gala@motorola.com>, "Wolfgang Denk" <wd@denx.de>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH] Driver for FECs on motorola DUET (87x/88x)
Date: Mon, 24 May 2004 21:11:23 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHAEDMCGAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <505FCE42-ADA6-11D8-B485-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I just used head.S, which works fine on the 82xx, as a model for the
> code in head_8xx.S.  I've been looking at some "common" PPC cache
> management functions that I'm not certain are doing the proper thing
> on the 8xx.  I'm suspecting some data corruption problems due to
> improper effects of cache instructions.
>
> There are some optimizations we can do to head_8xx.S, but I don't
> think there is anything incorrect in it.

I do think there is something wrong in head_8xx.S. Check
http://lists.linuxppc.org/linuxppc-embedded/200405/msg00109.html
for details.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
