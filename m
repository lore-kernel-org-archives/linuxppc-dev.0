From: Benjamin Herrenschmidt <bh40@calva.net>
To: Topi Kanerva <tkanerva@ees2.oulu.fi>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sound again [was: Re: xf4 bug report]
Date: Wed, 26 Jul 2000 15:10:18 +0200
Message-Id: <20000726131018.5434@mailhost.mipsys.com>
In-Reply-To: <Pine.GSO.4.21.0007261551420.7775-100000@stekt6>
References: <Pine.GSO.4.21.0007261551420.7775-100000@stekt6>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>so this behaviour is also happening on Burgundy. I've got an AWACS rev 3
>here in my Pismo (device-tree name for the chip is 'screamerawacs')
>and everything else works for me _except_ the damned built-in speakers.
>as long as I don't have any external speakers to connect to, this is _very_
>annoying, I have to boot to MacOS to listen to CD's etc etc... first I
>thought the problem was in the new version of the sound chip, but since
>Burgundies seem to have the same problem, I'm not so sure about it anymore.
>However, poking around the mixer code doesn't shed any more light into the
>problem.
>
>Now, what do the Burgundy and AWACS rev.3 have in common? Most certainly
>not the registers.

New "screamer" revisions of AWACS have more registers than defined in the
current Linux driver. I'm not sure this is the cause of our problem, but
it could be. I thinking about a problem setting up an external amplifier.

Note also that a working sound driver wont give you CD playback "out of
the box". On all new machines, the CD audio output is _not_ wired to the
sound chip. You have to use a player software that actually reads the
digital audio datas from the CD via ATAPI and sends them back to the
sound driver. There's an XMMS plugin for that, I managed to use it but it
still contains a lot of bugs.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
