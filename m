From: Amit Shah <amitshah@gmx.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
Date: Wed, 12 May 2004 20:00:58 +0530
Cc: Gabriel Paubert <paubert@iram.es>,
	Paul Mackerras <paulus@samba.org>, Dan Malek <dan@embeddededge.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
References: <c7nb0l$5e3$1@sea.gmane.org> <20040512134551.GB31780@iram.es> <Pine.GSO.4.58.0405121619110.19967@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0405121619110.19967@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405122000.58267.amitshah@gmx.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday 12 May 2004 19:51, Geert Uytterhoeven wrote:
> On Wed, 12 May 2004, Gabriel Paubert wrote:
> > Bottom line, 750 can't be used for SMP.
>
> Solution: divide memory in pieces, run multiple instances of Linux, each on
> its own CPU and memory piece, and use a piece of uncached RAM for
> implementing communication channels between CPUs ;-)

Wow, I was thinking about the exact same thing when I read this mail. I still
haven't grokked the PPC architecture to comment on all the mails on this
thread, but I guess this would be the easiest and surest way to make "SMP"
work.

--
Amit Shah
http://amitshah.nav.to/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
