Message-ID: <000901c300cd$b708f8a0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Wojciech Kromer" <krom@dgt-lab.com.pl>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	<Darin.Johnson@nokia.com>
References: <IGEFJKJNHJDCBKALBJLLEEPEFLAA.joakim.tjernlund@lumentis.se> <3E97BB43.6030409@dgt-lab.com.pl>
Subject: Re: kernel/timer.c
Date: Sat, 12 Apr 2003 10:29:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-2"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >hmm, why not just:
> >   expire = timespec_to_jiffies(&t);
> >if tv_sec and tv_sec are zero, do you need to sleep at all?
> >
> >    Jocke
> >
> >
> sleep(0) could be defined as:
> -schedule to next task if there is any (just call schedule() )
> -sleep minimum value (1 jiffie)
>
> default kernel (no timer patches) uses second definition,

No, linux uses the first definition(or whatever schedule_timeout(0) does).
If t is zero then expire also becomes zero.

>
> there is  special call schedule_timeout(MAX_SCHEDULE_TIMEOUT) which also
> calls schedule()
?


  Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
