Message-Id: <200009131556.QAA06666@hyperion.valhalla.net>
Date: Wed, 13 Sep 2000 16:56:28 +0100
Subject: Re: success 2.4.0-test8 with latest bk
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: daenzerm@student.ethz.ch, Benjamin Herrenschmidt <bh40@calva.net>
CC: Paul Mackerras <paulus@linuxcare.com>,
        "Linux -Dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Wed, Sep 13, 2000, Michel Dänzer wrote:
> Benjamin Herrenschmidt wrote:
>>
>> >> > You are lucky. For me it stops booting after the "freeing unused kernel
>> >> > memory" line. The one from 2 days ago had 2 days uptime.
>> >>
>> >> Usually this means that some function/data is marked __init while it
>> >must not.
>> >> Quick verification: #undef __init / #define __init etc.
>> >>
>> >> Just wondering: wouldn't it be possible to write some tool to find such
>> >bugs?
>> >
>> >Update: After a recompilation with today's updates, the latest bk kernel
>> >boots again for me.
>>
>> That's not the first time I notice this strange behaviour. I meant, this
>> happened to me randomly with various bk kernels for monthes. The problem
>> usually disappeared by itself after either recompiling the entire kernel,
>> or changing a few unrelated lines of code and then reompiling. That's
>> weird, I really don't know what can be causing that.
>
> Broken dependencies?

un-init vars? there's still quite a few warning messages fly by on
compile...

=====

from a mrproper of rsync-ed bk-devel (13:00 BST today).

boots OK (with BootX) on:

G3/beige
Lombard
9600/233

All three platforms show the weird coloured patterning on graphics chip
probe (I guess) - *even* the 9600 - which is IMSTT-based.  I have rage128
support built in.

2.4.0-t8 appears to be 'slower and choppier' than 2.2.17p20 (rather
subjective, I know).

The 9600 leaves the mac hardware cursor on the screen - which doesn't happen
with 2.2.17 (who deals with that?)...

BTW: two other questions:

1/ is devfs regarded as OK now (I built it in by mistake).
2/ has the fs-trashing problem been resolved?

I'd like to get back to doing 2.4.0 versions of the bits I'm working on -
but have only a little time for watching fsck ;-)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
