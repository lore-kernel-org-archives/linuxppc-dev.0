From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame
 Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Samuel Rydh
 <samuel@ibrium.se>
Subject: Re: [linux-fbdev] Re: Video driver bug
Date: Fri, 13 Oct 2000 22:43:23 +0200
Message-Id: <19340907141507.13024@192.168.1.10>
In-Reply-To: <Pine.LNX.4.10.10010101541220.375-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10010101541220.375-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>That's for 2.5.0. I think the first thing we need to do in 2.5.0 is to remove
>all `mess with non-visible VCs' support, so /dev/fb* works on the _current_
>video mode.


Well, my understanding is that MOL needs to be able to "probe" for all
supported mode. Doing so on a visible console would definitely be hell.
It does that in order to setup the MacOS-side driver mode list.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
