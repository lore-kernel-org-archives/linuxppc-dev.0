Message-ID: <3ADD7D28.45D39EA5@wanadoo.fr>
Date: Wed, 18 Apr 2001 13:40:25 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Tony Mantler <nicoya@apia.dhs.org>,
	"michel   =?iso-8859-1?Q?d=E4nzer?=" <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
References: <20010418090307.B0BF42EFB5@apollo.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The SysRq situation is more difficult to understand - but the code is very
> readable (nice stuff from Franz) - I just need to draw myself a picture
> (gave up at 3am this morning).
>
> How about a revolution  ;-?
>
> Could we come to a consensus about a key to use that will work for both
> Laptops & desktops?
>
> How about <Power> ?  It seems to send keycode 0x7f (or 0x7e on 3400)...

Very good idea. Except that it is already hijacked by xmon, IIUC. Maybe
one could make the use of SysRq and of xmon mutually exclusive :-)

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
