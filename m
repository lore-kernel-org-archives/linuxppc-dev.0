Message-ID: <3BE8358D.BFE0C2D2@denise.shiny.it>
Date: Tue, 06 Nov 2001 20:10:05 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Derrik Pates <dpates@dsdk12.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: recording audio?
References: <Pine.LNX.4.33.0110300920370.4960-100000@andromeda.dsdk12.net> <20011030172927.8256@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >> hmm, I wasn't even aware that there was an ALSA driver for powermac
> >> sound hardware.  I'll have to check that out...
> >
> >Last I checked, ALSA did not support any of the AWACS family chips in
> >PowerMac/PowerBook systems at all. There was a comment in a Todo log in
> >the source that mentioned they intended to do such a driver at some point,
> >but I don't know that one was ever written.
>
> SuSE people did, they have drivers for awacs, burgundy, tumbler and daca.

>From ALSA history:

2001-05-14 The driver 0.5.11 was released. Changes: IA64 arch support,
ALi 5451 driver added, AWACS driver added (for PPC), AC'97, PCM OSS
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
emulation, sequencer OSS emulation, AD1816A, ALS4000, AZT2320, CMIPCI,
CS4236, CS4281, CS461X, ES1968, Maestro 3, NM256, OPL3SA2, SB16,
SB-AWE, YMFPCI.

I'm downloading it now.


Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
