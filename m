Date: Mon, 16 Oct 2000 17:03:11 -0700 (PDT)
From: James Simmons <jsimmons@suse.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <19340908105038.32516@192.168.1.10>
Message-ID: <Pine.LNX.4.21.0010161700160.6261-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> While we are at it, I beleive we should also change atyfb.c so that
> currcon is no longer a global. My understanding is that can break multihead.

That is not the only thing broken for multihead support. The softback code
is severly broken. Also why don't we use the display_fg field in fb_info
instead. display_fg->vc_num is already their is it's more multihead
friendly. IMO real multihead support shoudl wait until 2.5.X since it
needs a pretty big cleanup.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
