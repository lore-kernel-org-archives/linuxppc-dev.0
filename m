Date: Wed, 18 Jul 2001 14:45:27 +0100
Subject: Re: 2.4 - buttons, temperature, ictc
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Bastien Nocera <hadess@hadess.net>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010718134723.DDD522EFD4@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   Wed, Jul 18, 2001,  Bastien Nocera wrote:
> Iain Sandoe wrote:
>> On Tue, Jul 17, 2001, Joseph P. Garcia wrote:
[snip]
>>>I agree.  At least at the moment, there are measures to have volume
>>>controls in the new input layer.  Else, why would there be macros in
>>>input.h for them.  [...]
>>>wm, and the code is clean, it should be tolerable.
>
> Better yet for handling the volume would be to get all these keys
> recognized by the Linux kernel (these keys don't produce any recognized
> keycode on my iMac's Apple Pro kbd), and then by XFree86 so that anybody
> can start adding shortcuts for their preferred window manager/desktop
> for these keys (that do also exist on x86, btw)

I'd guess that Franz has the ideas of how this will work ... this side is
out of my parish ...

>> How does the action end up getting routed to the sound driver?
>>[...]
>> (c) the OSS implementation *might* soon be sitting on top of an ALSA driver
>> talking to a non-onboard sound card (e.g. a pcmcia card) [although this is
>> not likely in the immediate future on PPC ... it is quite likely soon on x86
>> laptops]
>
> A pcmcia sound card ?! didn't know that existed.

Yep. there are some "on the stocks" - pro-audio stuff really tho' rather
than SBLive-type things (although those may exist too).

> Maybe USB speakers would be a better example (like on the Cube).

yeah. USB audio integration is a headache right now ...

>>[...]
>> I've been toying with the idea of a PMac-specific GUI mixer for a while -
>> the PMac hardware doesn't map well onto OSS.
>>
>> - that is, we have several capabilities (and growing with tumbler etc.) that
>> cannot be reached from the normal OSS interface.
> Can you explain ? OSS is indeed not very good for our mixers, maybe your
> ideas could be integrated into ALSA before it reaches 1.0 or gets
> included in the kernel.

I don't think there's any need to worry about this in ASLA - it already has
the ethic of describing the underlying hardware - no more no less.

The problem is with OSS - where the API embeds an idea of what the hardware
should look like - and that idea is *way* different from how PMac built-in
sound is configured.

I planned on using the OSS "special purpose uncommitted" ioctl() values to
access the PMac-specific stuff and (perhaps) making a GUI mixer that
followed the Apple-type sound manager interface (i.e. reflecting
mutually-exclusive inputs etc. etc.).

This would make dmasound continue to work with the "standard" mixers -
whilst allowing people who wanted a more closely matched interface to use
that.

>> Perhaps (at least the sound part) it could be integrated with eSound & aRts
>> so that coverage would come as part of a standard install?
> esound is _dead_. On PPC, it's a piece of junk, and Gnome 2.0 will use
> aRts through a C interface.

OK ... I don't (under any circumstances) want to start a desktop/toolkit war
- that was part of my point in making the suggestion.

ciao,
iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
