Message-ID: <3BE95FD3.9E14B266@folkwang-hochschule.de>
Date: Wed, 07 Nov 2001 17:22:43 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Derrik Pates <dpates@dsdk12.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: recording audio?
References: <Pine.LNX.4.33.0110300920370.4960-100000@andromeda.dsdk12.net> <20011030172927.8256@smtp.adsl.oleane.com> <3BE8358D.BFE0C2D2@denise.shiny.it>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Giuliano Pochini wrote:
>
> Benjamin Herrenschmidt wrote:
> >
> > >> hmm, I wasn't even aware that there was an ALSA driver for powermac
> > >> sound hardware.  I'll have to check that out...
> > >
> > >Last I checked, ALSA did not support any of the AWACS family chips in
> > >PowerMac/PowerBook systems at all. There was a comment in a Todo log in
> > >the source that mentioned they intended to do such a driver at some point,
> > >but I don't know that one was ever written.
> >
> > SuSE people did, they have drivers for awacs, burgundy, tumbler and daca.
>
> >From ALSA history:
>
> 2001-05-14 The driver 0.5.11 was released. Changes: IA64 arch support,
> ALi 5451 driver added, AWACS driver added (for PPC), AC'97, PCM OSS
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

pbook awacs support used to be broken in the cvs of a couple of
weeks ago and would not compile.
that may have been corrected by now, but i haven't checked for a
while.


--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
