Message-Id: <v03020900b2c32a566a02@[128.32.144.85]>
In-Reply-To: <Pine.LNX.3.96.990113124607.9183B-100000@globegate.utm.edu>
References: <19990113104026.C1056@dirkpitt.solsoft.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 14 Jan 1999 10:33:53 -0800
To: "David A. Gatwood" <marsmail@globegate.utm.edu>,
        Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
From: Michael Schmitz <schmitzm@uclink4.berkeley.edu>
Subject: Re: Porting to NuBus PowerMacs
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:55 PM -0600 1/13/99, David A. Gatwood wrote:
>On Wed, 13 Jan 1999, Hubert Figuiere wrote:
>> ADB: "CUDA" chip similar to several 68k Mac. Accessed thru the
>> "PrimeTime II". It is the 68HC05 and also handles PRAM, RTC,
>> power supply control.
>
>As long as we can get the base of the cuda portion of the chip, that's
>easy enough.

The CUDA hangs off VIA1 in the m68k machines. If this machine is just a
040 Mac with a PPC glued on top, the m68k code should do.

VIA1 and VIA2 are at fairly constant base addresses throughout the
m68k series. But Apple might have played some tricks on us again :-(

	Michael



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
