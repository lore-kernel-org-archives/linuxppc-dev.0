Date: Tue, 7 Nov 2000 15:08:00 +0100
From: Olaf Hering <olh@suse.de>
To: Steven Hanley <sjh@wibble.net>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bad vidmode on debian install
Message-ID: <20001107150800.A24537@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <20001108010609.A26617@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20001108010609.A26617@wibble.net>; from sjh@svana.org on Wed, Nov 08, 2000 at 01:06:10AM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 08, Steven Hanley wrote:

>
> All
>
> Anyway trying to upgrade form non debian dist to debian (potato) on my
> 7220/200, as it is old world I used the hfs floppy image. Anyway it boots
> fine but then the video mode is at a frequency such that no text is clear
> and it is moving around on the screen a bit (like running X i modes a
> machine cant handle)

You cant pass a video mode to platinumfb.
Do you have 834x624 and more than 8 bit color depth? If yes, change the
resolution or set the color depth to 8 bit.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
