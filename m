Date: Wed, 18 Apr 2001 14:16:55 +0100
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Tony Mantler <nicoya@apia.dhs.org>,
	martin costabel <costabel@wanadoo.fr>
Cc: "michel   d=?ISO-8859-1?B?5A==?=nzer" <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Message-Id: <20010418131708.CDFE02EFC5@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>>Anyway the SysRq key for USB must be handled somewhere else - I'm looking at
>>the mac_hid/adb/mac_keyb code which is specific to adb-based machines IIUC.
>
> Ah, ok. Wasn't sure about that.

duh... neither am I ;-) ... but I'll check later.

>
> [...]
>>Ben just mailed me a much better suggestion:
>>
>>"Pass the SysRq combination in as a kernel argument".
>>
>>This would allow those with SysRQ keys (e.g. ISO/ANSI kbds) to use it, power
>>books could have something that actually exists etc. etc.
> [...]
>
> Very nice idea.
>
> ...hopefully defaulted to the standard Alt-f13/printscreen/sysrq-key in the
> absense of the kernel commandline.

what about defaulting to <cntl>-<power> if CONFIG_POWERBOOK is set on the
kernel build?
- the power key is not too far from cntl on newer PowerBook keyboards -
anyone know about older ones?
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
