Message-ID: <3C13A6C4.ACFAF274@denise.shiny.it>
Date: Sun, 09 Dec 2001 19:00:36 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Byte order in sound drivers
References: <20011202095651.24942@smtp.wanadoo.fr> <20011202171724.10074@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >It depends on the HW you have. Most recent machines don't do HW
> >byteswap, and so accept only big-endian samples. The way this is
> >implemented in our driver currently is a bit weird though, the
> >setformat ioctl won't fail when trying to set an LE format, but
> >it will set the equivalent BE format. So the application is
> >expected to read back the format to figure out what had to be
> >done.

Same thing with some SoundBlasters. That's why there is a mess with
audio andianess.


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
