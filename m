Date: Sat, 24 Mar 2001 19:45:01 +0000
Subject: Re: Sound skips
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Giuliano Pochini <pochini@denise.shiny.it>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010324194439.431FB2EFE9@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> When I play music under high load the sound has a lot of
> short interruptions. It seems not to be related with I/O. I tried
> Alsaplayer

this is with Takashi Iwai's driver (it's the only one AFAIK)

>and xmms with OSS output. Xmms with esd is better but
> not perfect. Xmms uses a buffer of 2KB but I had to patch it to
> use a 8KB large one to make it play fine on my G3, but it still
> jumps sometimes on the G4.
> This happend on my G3 and a friend's G4(2000).
> I don't remember my 7300 had this problem.

which OSS driver are you using?
dmasound?
with or without my patches?

> I don't know what causes that (ints kept disabled too much time ?)
> but if someone has a patch to try I'me here.

there are a variety of things that can block for between 16 & 300 ms (not
necessarily IRQs).

what size fragments are you using?

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
