Date: Wed, 27 Oct 1999 11:24:13 +0200 (CEST)
From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Missing USB keys
In-Reply-To: <38165935.A73FB5BF@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9910271114510.1021-100000@macintoy.masq.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 27 Oct 1999, Martin Costabel wrote:

> [ ... ]

> 6. So where is the problem? The problem, of course, is that the two
> keymaps in drivers/usb/maps/ which are used to produce the translation
> table, are goddamn^H^H^H^H^H^H^Hstandard US keymaps. Therefore some of
> the keys of European Apple Extended keyboards are missing (maybe just
> one or two?). The right solution is therefore to add the missing keys in
> both keymaps, which is what I did, see the patch below. Another (not so
> universal) solution would be to replace both US keymaps by equivalent
> French ones. Or German ones, of course, but I suspect this would produce
> an identical usb_kbd_map translation table.

Up to that point I've traced it too.

> --- drivers/usb/maps/mac.map    1999/06/09 08:20:17     1.1
> +++ drivers/usb/maps/mac.map    1999/10/26 17:34:41
> +keycode 0x0a = at numbersign

How can I figure out the correct adb keycodes?  Hav'nt such a keyboard...

> --- drivers/usb/maps/usb.map    1999/04/28 11:52:38     1.1
> +++ drivers/usb/maps/usb.map    1999/10/26 17:34:42
> @@ -88,7 +88,7 @@
>  keycode  49 = backslash        bar             
                 ^^^^^^^^^^^^^^^^^^^^
> -keycode 50 =
> +keycode  50 = backslash        bar
                 ^^^^^^^^^^^^^^^^^^^^

Does'nt look like a good idea...

  Gerd

-- 
<script>alert("WARNING: You have JavaScript enabled.");</script>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
