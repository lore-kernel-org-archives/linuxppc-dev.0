Date: Mon, 25 Sep 2000 10:56:53 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Lanners <mlan@cpu.lu>
cc: daenzerm@student.ethz.ch, reshapiro@mediaone.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <200009231708.TAA00731@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10009251055090.28773-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Is this the already-known problem of handling an offset for the screen
> start within the framebuffer memory?
>
> Because I'm experiencing this as well with fbdev, and the problem is the
> same for all Apple non-accelerated framebuffers (control, platinum,

Sounds like Apple. It's been a problem on the m68k Apple framebuffers as
well, and got fixed for those by Geert in 3.3. The fix got lost or
incorrectly applied in 4.0 ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
