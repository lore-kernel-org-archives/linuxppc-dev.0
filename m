Message-ID: <3ABE49FF.8DD46595@denise.shiny.it>
Date: Sun, 25 Mar 2001 21:41:51 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Sound skips
References: <20010324194439.431FB2EFE9@apollo.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> > When I play music under high load the sound has a lot of
> > short interruptions. It seems not to be related with I/O. I tried
> > Alsaplayer
>
> this is with Takashi Iwai's driver (it's the only one AFAIK)
>
[...]
>
> which OSS driver are you using?
> dmasound?

Yes.

> with or without my patches ?

Plain 2.4.2. I'm d/l-ing your patches now. I'll let you know.

> > I don't know what causes that (ints kept disabled too much time ?)
> > but if someone has a patch to try I'me here.
>
> there are a variety of things that can block for between 16 & 300 ms (not
> necessarily IRQs).
>
> what size fragments are you using?

2K. I have to rise it to 8KB to work fine. My friend with the G4 still have
very few interruptions even with 8KB.

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
