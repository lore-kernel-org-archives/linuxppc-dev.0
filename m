Date: Tue, 15 Dec 1998 14:20:41 +0100 (MET)
From: Niels Roest <N.P.Roest@ITS.TUDelft.nl>
Subject: Re: AUDIO ON LINUX_PPC
In-reply-to: <366E598E.CCF78F93@zg.tel.hr>
To: Stanko Juzbasic <stanko.juzbasic@zg.tel.hr>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user@lists.linuxppc.org
Message-id: <Pine.HPP.3.95.981215140340.3613B-100000@elektron.et.tudelft.nl>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Dec 1998, Stanko Juzbasic wrote:

> 
> Is there anybody who encounterde the following problem?
> I'm  constantly running into something that seems like a problem with
> sound:
> 1. SOX plays .wav, .au .snd & .aiff files with gaps, whoch looks to me
>  like a disagreement on timing issues between the kernel buffer
>  &application buffer. (I've recompiled the kernel a few times).

That's odd. I have the same soundchip (AWACS) and I do not encounter
these problems. I had my odd problems with soundsoftware, mainly
because of the different endianess of software.
btw, 'sox' (or play) does not work on my machine? endianess I suppose.
I use other software (like wavplay).

> 2. CDs from the internal scd drive play flawlessly.

Same here.

> My platform:  PCI-PowerMac 7200, PowerPC 601 processor.
> System:   LINUX_PPC R4, kernel 2.1.24 (configured as standalone
>    workstation)
> All drives: SCSI

Maybe you should upgrade your kernel? I don't know about 2.1.24,
but 2.1.125 I use on my 7600 works okay.
I'd still say, try wavplay. It shouldn't need motif or lesstiff
(comment it out).

Comments anyone?

Niels



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
