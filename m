Message-ID: <001901c300df$4a2bb030$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Wojciech Kromer" <krom@dgt-lab.com.pl>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLEEPEFLAA.joakim.tjernlund@lumentis.se> <3E97BB43.6030409@dgt-lab.com.pl> <000901c300cd$b708f8a0$020120b0@jockeXP> <3E97DD20.6030908@dgt-lab.com.pl>
Subject: Re: kernel/timer.c
Date: Sat, 12 Apr 2003 12:35:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-2"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >>sleep(0) could be defined as:
> >>-schedule to next task if there is any (just call schedule() )
> >>-sleep minimum value (1 jiffie)
> >>
> >>default kernel (no timer patches) uses second definition,
> >>
> >>
> >
> >No, linux uses the first definition(or whatever schedule_timeout(0) does).
> >If t is zero then expire also becomes zero.
> >
> >
> maybe, my  missunderstood
>
> so, anyone knows what linus.t says about adding one jiffie  to every
> non-zero expire?

I think this is a bug. It should be enough to round up to nearest jiffie.
Ask on the linux kernel list.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
