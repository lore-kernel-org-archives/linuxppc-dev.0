Date: Wed, 18 Apr 2001 01:28:52 +0100
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Michel D=?ISO-8859-1?B?5A==?=nzer" <michdaen@iiic.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Message-Id: <20010418002843.8305BDBACB@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Michel Dänzer wrote:
> Iain Sandoe wrote:
>> On Tue, Apr 17, 2001, Michel Dänzer wrote:
>> > Iain Sandoe wrote:
>> [..]
>> >> Michel's advice to "option XkbDisable" gives partial functionality (VT
>> >> switches, server re-start).... but... with no mouse button emulation or
>> >> SysRq. (haven't tried MoL yet).
>> >
>> > The latter two aren't X but kernel issues.
>>
>> agreed - so how come installing a new version of X blows them away :-/
>> (maybe it's a co-incidence...  hmmm... did I try 2.4.4 _before_ I
>> upgraded... can't remember)...
>>
>> AH! I know what I changed - I've left off the "Xpmac backward compatibility"
>> CONFIG option ... should I still use that with XF4 ?
>
> Don't think so. The thing is XF4 doesn't do mouse button emulation, the kernel
> does that.

Yep.  But maybe it puts the emulated button presses on different keys
with/without backward compat.  I'll have a look in a minute.

The frustration is that the keycodes are listed in
/proc/sys/dev/mac_hid/mouse_buttonX_keycode - but finding out which physical
key combination relates to the numbers doesn't appear to be trivial.

>For SysRq I suspect that has to do with Linux keycodes?

Not soley/directly - I've had linux keycodes enabled (and the new input
layer) for months... (including in 2.2.x back-ported version in Ben's old
tree).

I know I'm asking dumb questions... but it's gradually beginning to make
some sense..
thanks,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
