Message-ID: <3816EA84.41450D3C@wanadoo.fr>
Date: Wed, 27 Oct 1999 14:05:24 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Missing USB keys
References: <Pine.LNX.4.10.9910271114510.1021-100000@macintoy.masq.in-berlin.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gerd Knorr wrote:
> 

> How can I figure out the correct adb keycodes?  Hav'nt such a keyboard...

There are German keymaps in the console-tools rpm, for example
/usr/lib/kbd/keymaps/mac/mac-de-latin1-nodeadkeys.kmap.gz
I guess you would have to compare this with a corresponding German usb
keymap. Don't know where to find one, but I'm sure such keymaps have
been offered on the net.

> > --- drivers/usb/maps/usb.map    1999/04/28 11:52:38     1.1
> > +++ drivers/usb/maps/usb.map    1999/10/26 17:34:42
> > @@ -88,7 +88,7 @@
> >  keycode  49 = backslash        bar
>                  ^^^^^^^^^^^^^^^^^^^^
> > -keycode 50 =
> > +keycode  50 = backslash        bar
>                  ^^^^^^^^^^^^^^^^^^^^
> 
> Does'nt look like a good idea...

Looks bad, indeed. Works, however, on the B&W G3 where I tried it :-)
It just means that both USB keycodes 49 and 50 will be mapped to the
same ADB keycode. I don't quite remember (have been away from linux for
a month), but I think only one of the two actually exists on a key.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
