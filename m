Content-Type: text/plain;
  charset="iso-8859-1"
From: Mark Chambers <markc@mail.com>
Reply-To: markc@mail.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Control-C in bash ???
Date: Tue, 14 Jan 2003 08:44:09 -0500
References: <20030113193102.E7B7CC608E@atlas.denx.de>
In-Reply-To: <20030113193102.E7B7CC608E@atlas.denx.de>
MIME-Version: 1.0
Message-Id: <200301140844.09234.markc@mail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for your help on this one.  I changed the last line of etc/inittab to

        3:2345:respawn:/sbin/mingetty --noclear tts/0

and added "tts/0" to etc/securetty and now I get a console with job control.
I don't know how long it would have taken me to discover "job control" or "controlling tty"!!
(I'm learning linux from the ground up)

Thanks again,
Mark Chambers


Original message:
> On a PC, I can, for instance, enter "ping 192.168.1.4", then hit Control-C and
> stop the ping.  For the life of me, I can't figure out how to do the same on
> my MPC860 system!!!

> I have an MPC860 running 2.4.19, with a mostly unmodified eldk distribution
> from Wolfgang Denx.  I did modify the init script to use /dev/console instead
> of /ttyx (standard driver using SMC1).  I'd not only like a solution, I want
> to undertand how this works - I've poked around and I can't figure out what's
> supposed to happen - Is the shell that generates a SIGINT, or the uart
> driver, or what?  Any enlightenment will be greatly appreciated...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
