Message-Id: <200008030457.FAA15430@hyperion.valhalla.net>
Date: Thu, 03 Aug 2000 05:56:54 +0100
Subject: Re: 2.4.0-t5 lockup on shutdown.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: William Blew <wblew@home.com>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 3, 2000,  William Blew wrote:
> Iain Sandoe wrote:
>>
>> Does anyone know the cause of the (sometimes) complete lock-up of 2.4.0-t5
[snip]

> layer, the VIA (CUDA) interrupt dies *grin*.

as in 'just disappears' ? i.e. as if some driver has requested it be
deleted?... this would certainly explain more than one phenomenon... (I
could see that also causing sound flakiness too - since we need the cuda for
that)...

Note that I haven't used IDE (AHAIK) in the cases mentioned - all my disk,
other than CDROM, is on SCSI... but I could try a controlled test (later).

what else causes the interrupt to 'disappear'?
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
