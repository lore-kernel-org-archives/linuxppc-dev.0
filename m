Date: Wed, 8 Nov 2000 09:46:25 +1100
From: Steven Hanley <sjh@wibble.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: bad vidmode on debian install
Message-ID: <20001108094625.B10734@svana.org>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <20001108010609.A26617@wibble.net> <20001107150800.A24537@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20001107150800.A24537@suse.de>; from olh@suse.de on Tue, Nov 07, 2000 at 03:08:00PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 07, 2000 at 03:08:00PM +0100, Olaf Hering wrote:
> On Wed, Nov 08, Steven Hanley wrote:
>
> >
> > All
> >
> > Anyway trying to upgrade form non debian dist to debian (potato) on my
> > 7220/200, as it is old world I used the hfs floppy image. Anyway it boots
> > fine but then the video mode is at a frequency such that no text is clear
> > and it is moving around on the screen a bit (like running X i modes a
> > machine cant handle)
>
> You cant pass a video mode to platinumfb.

it is a Mach 64 video card

> Do you have 834x624 and more than 8 bit color depth? If yes, change the
> resolution or set the color depth to 8 bit.

wouldnt doing this involve the passing of a video=atyfb:vmode:8 or some such
?

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh
Look Up In The Sky
    Is it a bird?   No
        Is it a plane    No
            Is it a small blue banana?
Yes

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
