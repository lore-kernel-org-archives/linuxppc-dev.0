Date: Sat, 15 Apr 2000 02:43:57 -0400 (EDT)
From: Scott Knight <scott@re-104-1.read.indiana.edu>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Scott Knight <scott@re-104-1.read.indiana.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel 2.3 make error
In-Reply-To: <38F81215.99D3656A@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10004150242590.16661-100000@fletch.read.indiana.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nope, I dont thats my problem. Thanks, some of thes things, that you would
think wouldnt cause dependincies do and its kinda a pain. But thanks. Also
anyone know if the 2.3 kernel still does the weird console stuff when you
highlight things with the mouse? At least it did it on my 8500. Thanks

	Scott Knight

On Sat, 15 Apr 2000, Martin Costabel wrote:

>
> Scott Knight wrote:
> >
> >         Ive tried over the past three days grabbing the latest kernel from
> > pauls tree. And everytime i get the same error near the end. I think it
> > has to do with the controlfb.c file or something having to do that I need
> > the control frame buffer, if anyone knows why I ight be getting this error
> > thatd be great. Below is the error.
> []
> > drivers/video/video.o: In function `init_control':
> > drivers/video/video.o(.text.init+0x1354): undefined reference to `mac_map_monitor_sense'
>
> Do you have CONFIG_FB_COMPAT_XPMAC=y in your .config? You need it even
> if you don't use Xpmac as X server.
>
> --
> Martin
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
