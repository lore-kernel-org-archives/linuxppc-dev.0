Date: Wed, 26 Jul 2000 16:13:46 +0300 (EET DST)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: sound again [was: Re: xf4 bug report]
In-Reply-To: <20000726131018.5434@mailhost.mipsys.com>
Message-ID: <Pine.GSO.4.21.0007261610420.7807-100000@stekt6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 Jul 2000, Benjamin Herrenschmidt wrote:

>New "screamer" revisions of AWACS have more registers than defined in the
>current Linux driver. I'm not sure this is the cause of our problem, but
>it could be. I thinking about a problem setting up an external amplifier.
>

Now, do you propose any method of determining exactly *where* the problem
lies? How can we manage to get hold of the specs of the new audio chips?
I mean, it works on MacOS, someone ought to know how to program the device!

>Note also that a working sound driver wont give you CD playback "out of
>the box". On all new machines, the CD audio output is _not_ wired to the
>sound chip. You have to use a player software that actually reads the
>digital audio datas from the CD via ATAPI and sends them back to the

I know. I use "cdparanoia 1- - | play -"
However it seems to be quite solid, i.e. I don't ever hear any 'blips'
resulting from jitter, so maybe the DVD-ROM drive is just reading the
audio data with full fidelity.

-topi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
