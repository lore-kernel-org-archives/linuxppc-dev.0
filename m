Message-Id: <v04003a14b702bc961130@[24.70.162.12]>
In-Reply-To: <20010418002843.8305BDBACB@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 17 Apr 2001 22:40:39 -0500
To: "Iain Sandoe" <iain@sandoe.co.uk>,
	=?iso-8859-1?Q?=22Michel_D=E4nzer=22?= <michdaen@iiic.ethz.ch>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:28 PM -0500 4/17/2001, Iain Sandoe wrote:
[...]
>The frustration is that the keycodes are listed in
>/proc/sys/dev/mac_hid/mouse_buttonX_keycode - but finding out which physical
>key combination relates to the numbers doesn't appear to be trivial.

I think if you enable linux keycodes on the console, then use showkeys, you
can get the proper values to plug into those files.

Bit of a PITA, but at least they'll (hopefully) always be consistant.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
