From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Frame Buffer Device
 Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-fbdev] Re: Video driver bug
Date: Sat, 14 Oct 2000 19:18:54 +0200
Message-Id: <19340908105038.32516@192.168.1.10>
In-Reply-To: <Pine.LNX.4.10.10010132313270.381-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10010132313270.381-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Here are my fixes for aty128fb, atyfb, platinumfb, and tdfxfb.
>
>Igafb is not affected since it sets disp during initialization only.
>
>Can someone please test these patches so I can send them to Linus? I'm unable
>to test any of them (besides a simple compile test). Thanks!

While we are at it, I beleive we should also change atyfb.c so that
currcon is no longer a global. My understanding is that can break multihead.

Any objection ?

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
