Date: Fri, 13 Oct 2000 23:36:47 -0700 (PDT)
From: James Simmons <jsimmons@suse.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Samuel Rydh <samuel@ibrium.se>
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <19340907141507.13024@192.168.1.10>
Message-ID: <Pine.LNX.4.21.0010132334380.1195-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >That's for 2.5.0. I think the first thing we need to do in 2.5.0 is to remove
> >all `mess with non-visible VCs' support, so /dev/fb* works on the _current_
> >video mode.
>
>
> Well, my understanding is that MOL needs to be able to "probe" for all
> supported mode. Doing so on a visible console would definitely be hell.
> It does that in order to setup the MacOS-side driver mode list.

Call ioctl FBIOPUT_VSCREENINFO with fb_var_screeninfo.activate with
FB_ACTIVATE_TEST set. This will test the mode without actually setting the
hardware.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
