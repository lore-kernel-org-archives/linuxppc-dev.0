Date: Wed, 29 Aug 2001 13:51:27 +0200
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Subject: Re: Xvideo acceleration: GATOS for PPC?
To: mlan@cpu.lu
Cc: DebianPPC <debian-powerpc@lists.debian.org>,
	linuxppc-dev@lists.linuxppc.org
Message-id: <3B8CD73F.6F2693C9@inn.ericsson.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <200108282111.XAA00990@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> Hi all,
>
> During my quest for improved performance in such goodies as xine and
> vlc, I came across the fact that currently on PPC, the X server eats
> between 20 and 40 percent of the cpu cycles, whereas on i386 (with GATOS
> drivers), it just sleeps doing nothing....

I have seen something like this on plain x86. Turns out it was the gnome
"desk guide" that tries to update the thumb nail display with the screen
contents and most of the processing ends up in X for some reason.

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
