Message-ID: <38F81215.99D3656A@wanadoo.fr>
Date: Sat, 15 Apr 2000 08:54:13 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Scott Knight <scott@re-104-1.read.indiana.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel 2.3 make error
References: <Pine.LNX.4.10.10004141910200.6328-100000@fletch.read.indiana.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Scott Knight wrote:
>
>         Ive tried over the past three days grabbing the latest kernel from
> pauls tree. And everytime i get the same error near the end. I think it
> has to do with the controlfb.c file or something having to do that I need
> the control frame buffer, if anyone knows why I ight be getting this error
> thatd be great. Below is the error.
[]
> drivers/video/video.o: In function `init_control':
> drivers/video/video.o(.text.init+0x1354): undefined reference to `mac_map_monitor_sense'

Do you have CONFIG_FB_COMPAT_XPMAC=y in your .config? You need it even
if you don't use Xpmac as X server.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
