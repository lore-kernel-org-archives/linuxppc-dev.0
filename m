Message-Id: <v04003a16b7034004f176@[24.70.162.12]>
In-Reply-To: <20010418124421.7E7702EFE5@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 18 Apr 2001 08:06:56 -0500
To: "Iain Sandoe" <iain@sandoe.co.uk>,
	martin costabel <costabel@wanadoo.fr>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
Cc: =?iso-8859-1?Q?=22michel___d=E4nzer=22?= <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:44 AM -0500 4/18/2001, Iain Sandoe wrote:
[...]
>> Also, what happens if someone wants to hook up a PC USB keyboard to their
>> mac? Obviously not generating an NMI is a given, but no access to SAK is
>> avoidable.
>
>Apparently, some Apple keyboards don't have a <power> key either.

The Happy-Hacking ADB keyboard for one (just looked at the web page, was
the first that came to mind).

I'm not sure about apple designed keyboards besides those on the Mac+ and
like machines (non-adb). All the ones I've seen - FrogDesign/IIGS, Apple
Extended II, AppleDesign, Apple Adjustable, etc - have it. I haven't seen
an Apple Extended I or a non-extended (was there one?) for years, so I
can't say about those ones.


>Anyway the SysRq key for USB must be handled somewhere else - I'm looking at
>the mac_hid/adb/mac_keyb code which is specific to adb-based machines IIUC.

Ah, ok. Wasn't sure about that.


[...]
>Ben just mailed me a much better suggestion:
>
>"Pass the SysRq combination in as a kernel argument".
>
>This would allow those with SysRQ keys (e.g. ISO/ANSI kbds) to use it, power
>books could have something that actually exists etc. etc.
[...]

Very nice idea.

...hopefully defaulted to the standard Alt-f13/printscreen/sysrq-key in the
absense of the kernel commandline.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
