Date: Wed, 18 Apr 2001 13:03:28 +0100
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: Tony Mantler <nicoya@apia.dhs.org>,
	"michel   d=?ISO-8859-1?B?5A==?=nzer" <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Message-Id: <20010418120326.E0D802EFB6@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Wed, Apr 18, 2001,  Martin Costabel wrote:
>> The SysRq situation is more difficult to understand - but the code is very
>> readable (nice stuff from Franz) - I just need to draw myself a picture
>> (gave up at 3am this morning).
>>
>> How about a revolution  ;-?
>>
>> Could we come to a consensus about a key to use that will work for both
>> Laptops & desktops?
>>
>> How about <Power> ?  It seems to send keycode 0x7f (or 0x7e on 3400)...
>
> Very good idea. Except that it is already hijacked by xmon, IIUC. Maybe
> one could make the use of SysRq and of xmon mutually exclusive :-)

xmon uses <CMD aka pretzel>-power which causes an NMI - this is a hardware
thing AFAIK and can't be altered.

What I'm suggesting is <power> as a modifier (which is basically what SysRq
is)  so SysRq sequences would be like:

<power>-k  (SAK) ;  <power>-s (emergency sync). etc. etc.

<power> has the right "feel" to it (i.e. "don't touch unless you know what
you're doing").

I don't think it should interfere with the use of <CMD>-power for xmon
interrupt - MacOS manages to use it for NMI for MacsBug and <power> for
triggering a shutdown dialogue...

Although, I suppose from a User's POV - we might want (one day) to trigger a
shutdown dialogue as well ... ho hum... although a well-designed dialogue
could include the SysRq actions (which are emergency stuff) as options.

I guess we could use <CNTL>-power as the SysRq modifier - but it starts to
become a little unwieldy - because you need to hold down three keys to get
the SysRq action (well, you do now as it happens)...

so, perhaps, <CNTL>-<Power>-k etc.

thoughts?

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
