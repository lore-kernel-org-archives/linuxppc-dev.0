Date: Tue, 10 Oct 2000 22:23:08 -0700 (PDT)
From: James Simmons <jsimmons@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Samuel Rydh <samuel@ibrium.se>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, olh@suse.de
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <Pine.LNX.4.10.10010102150540.375-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0010102221440.332-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > We really should design a cursor api. A api independent of the console so
> > X servers can take advantage of it. IMHO fbcon-cfbX and freinds should
> > go away. What I purpose is it be replaced by 3 standard functions:
> >
> > fillrect
> > copyarea
> > drawimage
> >
> > This with a clean cursor api woudl allow display_switch to go away.
>
> 100% agreed. But that should wait for 2.5.0. Now we have to hunt for
> release-critical bugs in the current version.

Okay. What to get a list together of know bugs?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
