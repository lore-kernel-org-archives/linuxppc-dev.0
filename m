Message-Id: <v04003a17b703451420e2@[24.70.162.12]>
In-Reply-To: <20010418131708.CDFE02EFC5@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 18 Apr 2001 08:23:17 -0500
To: "Iain Sandoe" <iain@sandoe.co.uk>,
	martin costabel <costabel@wanadoo.fr>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
Cc: =?iso-8859-1?Q?=22michel___d=E4nzer=22?= <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:16 AM -0500 4/18/2001, Iain Sandoe wrote:
[...]
>>>"Pass the SysRq combination in as a kernel argument".
>>>
>>>This would allow those with SysRQ keys (e.g. ISO/ANSI kbds) to use it, power
>>>books could have something that actually exists etc. etc.
>> [...]
>>
>> Very nice idea.
>>
>> ...hopefully defaulted to the standard Alt-f13/printscreen/sysrq-key in the
>> absense of the kernel commandline.
>
>what about defaulting to <cntl>-<power> if CONFIG_POWERBOOK is set on the
>kernel build?
>- the power key is not too far from cntl on newer PowerBook keyboards -
>anyone know about older ones?

Maybe just make the default a seperate compile-time option, rather than
CONFIG_POWERBOOK. It wouldn't be very clear to someone why sysrq stopped
working on their desktop when they purposely or accidentally compiled a new
kernel with pbook support turned on. :)


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
