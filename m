Date: Fri, 20 Oct 2000 10:53:49 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Topi Kanerva <tkanerva@ees2.oulu.fi>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB-Mouse
In-Reply-To: <Pine.GSO.4.21.0010191518150.27486-100000@stekt6>
Message-ID: <Pine.LNX.4.10.10010201050520.23902-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >[snip]
> >input0: Macintosh mouse button emulation
> >[snip]
>
> as a side note, I suppose you people know how the mouse button emulation
> works. I couldn't make it work at any rate on my Pismo PowerBook...

The trick is to use the keycodes a PC keyboard would emit for the keys you
intend to use for emulation. The default is set to have fn-cntrl and
fn-option as emulation keys (which magically fails to interfere with other
functions of these keys, quite unlike the old emulation).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
