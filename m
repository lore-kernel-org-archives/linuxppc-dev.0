Date: Wed, 18 Apr 2001 10:03:11 +0100
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Tony Mantler <nicoya@apia.dhs.org>,
	"michel d=?ISO-8859-1?B?5A==?=nzer" <michdaen@iiic.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Message-Id: <20010418090307.B0BF42EFB5@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Wed, Apr 18, 2001, Tony Mantler wrote:
> At 7:28 PM -0500 4/17/2001, Iain Sandoe wrote:
> [...]
>>The frustration is that the keycodes are listed in
>>/proc/sys/dev/mac_hid/mouse_buttonX_keycode - but finding out which physical
>>key combination relates to the numbers doesn't appear to be trivial.
>
> I think if you enable linux keycodes on the console, then use showkeys, you
> can get the proper values to plug into those files.
>
> Bit of a PITA, but at least they'll (hopefully) always be consistant.

Well, I looked at the source and the mouse button emulation is OK (on
right-ctl, alt).  Don't quite understand when/how it moved from <alt-2,
alt-3> ;-)

====

The SysRq situation is more difficult to understand - but the code is very
readable (nice stuff from Franz) - I just need to draw myself a picture
(gave up at 3am this morning).

How about a revolution  ;-?

Could we come to a consensus about a key to use that will work for both
Laptops & desktops?

How about <Power> ?  It seems to send keycode 0x7f (or 0x7e on 3400)...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
