Message-Id: <200007051418.PAA26120@hyperion.valhalla.net>
Date: Wed, 05 Jul 2000 15:18:49 +0100
Subject: Re: seemingly random lock-up with kernel 2.2.17p7
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: daenzerm@student.ethz.ch, b.judd@xtra.co.nz
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
> Gwyn Judd wrote:
>>
>> On Wed, Jul 05, 2000 at 08:51:09AM -0500, me@johngrimes.com wrote:
>> > Gwyn,
>> >       Might be related or might not but I have recently started having
>> > troubles too with random locks.
>> >       Now I am running 2.2.15 (but this started happening soon after the
>> > upgrade)
>> >       Now my error is not directly with the kernel though.  If I am in
>> > the console it has never happened but only if I am in X.  In fact its X
>> > that crashes but as no keys work it doesn't matter.  Now I always have
>> > xmms open when I crash but it also might be a screensaver problem as it
>> > always happens when the screensaver is one (which is the majority of the
>> > time though).
>> >       Does this sound similar?
>> >       Do you have an ati rage 128gl card by chance?
>> >       John
>>
>> This all sounds quite familiar. The lockups have happened with both xmms
>> and mpg123. I have no idea if it is a full system lock or just X since I
>> have no remote machine to ping it with, all I am able to do is force
>> reboot. It happened also with 2.2.15 I think as well as 2.2.16
>
> What versions of X are you using? Someone reported lockups with the 4.0 r128
> driver a long time ago and someone else suggested it might be bad interaction
> between the graphics and sound devices.

There is a little wierditude with sound.  I've seen X grind to a halt on a
300MHz G3 with smaller buffer sizes - which may just be a manifestation of
the more general problem:

Quote from Geert "Richard Zidlicky found a bug that made the driver always
use 1 byte buffers, which gave very bad results on slow machines. It was
fixed in 2.3.x."

I'm on the case of back-porting the 2.3.xx dmasound stuff to 2.2.17pre7 -
but don't hold your breath (there's a lot of understanding to gain on my
part - because the sleep queue stuff changed).

Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
