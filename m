Message-ID: <20011023233821.76653.qmail@web13101.mail.yahoo.com>
Date: Tue, 23 Oct 2001 16:38:21 -0700 (PDT)
From: Dave Ray <g4tinker@yahoo.com>
Subject: Re: Sound on G4 tower, success 
To: Derrik Pates <dpates@dsdk12.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.33.0110231224250.7493-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- Derrik Pates <dpates@dsdk12.net> wrote:
>
> What errors are those? Nothing you've posted so far
> looks like an error to
> me.
>
> > Oct 19 20:53:48 garuda kernel: tumbler:no device
>
> That's from not having a devnode for "amp-mute",
> "headphone-mute" or
> "headphone-detect". I don't think that's a problem.
>
> > Oct 19 20:53:48 garuda kernel: i2c-keywest: Ack
> Status
> > on addr expected but got: 0x09 on addr: 0x34
>
> That's just because the tas3001 driver code (the
> mixer for the
> Tumbler/Texas) is searching all available I2C buses,
> and the first one
> doesn't have what it's looking for.

Thanks for your insight to these error messages. After
seeing your confidence that syslog looked okay, I
hypothesized that the output jacks may be live even
though the built-in speaker is dead silent. I plugged
the output audio jacks to an amplifier, and voila,
sound is is working there just fine.

Under MacOS (and Open Firmware) the internal speaker
is on by default, and turns off only when the audio
jack is physically connected. I assumed it was a
hardware switch and that if sound is working, I should
expect to hear it on the internal speaker. Not the
case apparently with dmasound_pmac. The speaker is
completely dead, and the output jack is always on,
regardless of whether a plug is connected. Is this a
bug? (Don't get me wrong, I'm delighted that it
works!)

This should go in some FAQ. Who's maintaining an FAQ
for the Mac G4 towers?

Thanks for all your help looking over my data,

Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
