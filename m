Date: Sat, 10 Mar 2001 15:26:44 +0000
Subject: Re: provision of "driver" type facilities from user-space
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010310152647.A49E12EFE9@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>> I want to put a layer in between user-space and a driver (dmasound).
>>
>> The reason is - that I want to provide facilities (transparently) to
>> applications and these facilities cannot be (sensibly) placed in the driver
>> [e.g. rate conversion and so on].
>
> Isn't this what esd and arts do?

yes... in a way.

I was hoping to avoid running a separate daemon...

but, well, maybe that's the only way to achieve it.

I thought the question worth asking.

a sort of attempt to Keep It Simple...

...and then there's the "favourite" way of doing things issue...

ah well.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
