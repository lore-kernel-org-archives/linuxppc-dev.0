From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Date: Sat, 8 Jan 2000 22:39:41 +0100
Message-Id: <200001082139.WAA00528@macintoy.masq.in-berlin.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: iMac DV and aty128fb
In-Reply-To: <Pine.LNX.3.96.1000108185120.23736D-100000@shell>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In lists.linuxppc.dev, you wrote:
> 
> On Sat, 8 Jan 2000, BenH wrote:
> 
> > /proc/device-tree/compatible
> 
> PowerMac2,1MacRISCPower Macintosh
> 
> could someone with a non-DV iMac (eg. Rev.A - D) do a fbset and let me
> know the output?

Below is my /etc/fb.modes.  I've figured them out by trial and error.
RevB iMac.  The important thing is that the iMac syncs only on 60 kHz
horizontal.

  Gerd

---------------------------------------------------------------

mode "640x480"
    # D: 50.808 MHz, H: 60.486 kHz, V: 118.136 Hz
    geometry 640 480 640 9798 8
    timings 19682 80 24 28 1 96 3
    hsync high
    vsync high
    accel true
endmode

mode "800x600"
    # D: 63.279 MHz, H: 60.381 kHz, V: 94.345 Hz
    geometry 800 608 1024 6124 8
    timings 15803 120 32 28 1 96 3
    hsync high
    vsync high
    accel true
endmode

mode "console"
    # D: 78.524 MHz, H: 59.850 kHz, V: 74.813 Hz
    geometry 1024 768 1024 6128 8
    timings 12735 160 32 28 1 96 3
    hsync high
    vsync high
    accel true
endmode


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
