Message-ID: <39116DF7.4CD7FFBD@mondonet.net>
Date: Thu, 04 May 2000 14:32:55 +0200
From: Mario Scarpa <m.scarpa@mondonet.net>
MIME-Version: 1.0
To: Gabriel Ricard <g_ricard@yahoo.com>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (still there)
References: <20000503175115.20311.qmail@web1704.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Ricard wrote:
>
> My symptoms
> include a wandering mouse pointer: i.e. when I am
> typing rapidly, X will occasionally think I've clicked
> the mouse button and the focus goes to where the
> pointer was located.

Same for me. And it is really annoying to write the
emails two or three times ;-)
My mouse is a brand x 5$ usb mouse with three buttons...

> I also have strange problems with
> my lombard locking up when I leave it in the screen
> saver overnight or turn the brightness all the way
> down.

Yes, I used to have this too but I solved it using 2.2.15pre20
X 3.3.6 and booting without specifying "no video options"
in BootX. As for the video opts I am using let me know if
you need them and will mail to you.
Same for the .config.

> I haven't had any problems related to massive
> network activity.

Bah, this seems to be my own problem...

> As for the USB->serial adapter, I have one from
> Keyspan which several people are working on developing
> drivers for. Search the list archives for more detail
> on that.

Many thanks I will do it.

Bye,

--
Mario Scarpa

Mondonet NOC
Phone: +39 06 52.47.37.02

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
