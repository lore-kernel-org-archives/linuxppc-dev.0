Date: Tue, 10 Oct 2000 20:18:53 -0700 (PDT)
From: James Simmons <jsimmons@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Samuel Rydh <samuel@ibrium.se>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, olh@suse.de
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <Pine.LNX.4.10.10010101541220.375-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0010102014400.803-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> That's for 2.5.0. I think the first thing we need to do in 2.5.0 is to remove
> all `mess with non-visible VCs' support, so /dev/fb* works on the _current_
> video mode.

Yep. I still like the to see the current drivers move closer to the new
api.

> > I think we must do something in 2.4.0-testX, since you can abuse the bug to
> > panic the box.
>
> Does this fix the problem on atyfb? I'm not able to test it myself.

I haven't tested it yet. I don't have ATI card for myself yet. I will take
a close look at what we can do. Give a few days. Right now I'm working on
a rewrite of vgacon and vga16fb. I hope to get it so we can go from vgacon
to fbcon and back again. This will help alot in driver developement. VC
switch and rrmod a driver. Regain the VC back.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
