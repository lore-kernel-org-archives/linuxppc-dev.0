Date: Mon, 25 Sep 2000 20:38:08 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        R Shapiro <reshapiro@mediaone.net>,
        Michel Dänzer <daenzerm@student.ethz.ch>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <Pine.LNX.4.21.0009251945050.1113-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10009251941450.5808-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>   Hmm does this mean that mmapping the framebuffer doesn't give you the
> start of vram but vram+offset ? if yes then we have a big problem here.

No, atyfb reserved some space at the end of vram (MMIO mirrored there,
please try to memset (0) that area for kicks. Makes you think you're
melting your display).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
