Date: Wed, 26 Jul 2000 15:55:12 +0300 (EET DST)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
To: Steffen Haeuser <SteffenH@hyperion-software.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: sound again [was: Re: xf4 bug report]
In-Reply-To: <yam8242.1826.146779528@mail.lf-online.de>
Message-ID: <Pine.GSO.4.21.0007261551420.7775-100000@stekt6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 Jul 2000, Steffen Haeuser wrote:

>Just wanted to tell that after putting earphones to the Mac, the sound comes.
>Appearently it is only the internal speaker which does not work.
>

so this behaviour is also happening on Burgundy. I've got an AWACS rev 3
here in my Pismo (device-tree name for the chip is 'screamerawacs')
and everything else works for me _except_ the damned built-in speakers.
as long as I don't have any external speakers to connect to, this is _very_
annoying, I have to boot to MacOS to listen to CD's etc etc... first I
thought the problem was in the new version of the sound chip, but since
Burgundies seem to have the same problem, I'm not so sure about it anymore.
However, poking around the mixer code doesn't shed any more light into the
problem.

Now, what do the Burgundy and AWACS rev.3 have in common? Most certainly
not the registers.


-topi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
