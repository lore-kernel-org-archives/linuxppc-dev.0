Message-ID: <38EB8412.132D57F0@erols.com>
Date: Wed, 05 Apr 2000 14:21:06 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Hard freezing w/ mp3s [Was: Re: XFree 4 & sound problems]
References: <20000405190131.025451@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> That's really interesting since there is no bug I know of. Can you please
> tell me:
>
>   - The exact machine model

Sawtooth G4 450

>   - Did the problem began with a specific kernel or did you always had it

Not sure.  I have only used your 2.2.15 to install and now 2.2.15pre14 that
I compiled (I am working on getting 2.3.99 to boot correclty)

>   - Do you use the "nap" mode for power management ? (assuming it's a
> powerbook)

It's a desktop.

It happens seemingly randomly, and generally only after being on for a while.
And I am 99% sure it only happens when I start tweaking w/ multiword and
unmask irq..

I even wrote down the exact xmon output one time :-)
    vector: 300  at pc=C003e6d0, msr=9032, sp=08459c60 [c8459bb0]
    dar=d453d724, dsisr=40000000
    current=c8458000, pid=6536, comm=slocate

I guess that is the slocate one...

I understand the basic information in that (I have taken my cpu and assembly
classes), but definately not enough to debug wtf it means is wrong.  I have
deduced the error from the fact that it happens during a period of data
transfer (mp3s or a database execution; the latter only happened once)
and that I am almost certain it only happens when I play with the ide
settings...

--Nelson Abramson


--
Shouldn't people be arrested and persecuted for engaging in their
constitutional rights?  http://www.opendvd.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
