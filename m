Message-ID: <3E97DD20.6030908@dgt-lab.com.pl>
Date: Sat, 12 Apr 2003 11:32:16 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel/timer.c
References: <IGEFJKJNHJDCBKALBJLLEEPEFLAA.joakim.tjernlund@lumentis.se> <3E97BB43.6030409@dgt-lab.com.pl> <000901c300cd$b708f8a0$020120b0@jockeXP>
In-Reply-To: <000901c300cd$b708f8a0$020120b0@jockeXP>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>>sleep(0) could be defined as:
>>-schedule to next task if there is any (just call schedule() )
>>-sleep minimum value (1 jiffie)
>>
>>default kernel (no timer patches) uses second definition,
>>
>>
>
>No, linux uses the first definition(or whatever schedule_timeout(0) does).
>If t is zero then expire also becomes zero.
>
>
maybe, my  missunderstood

>>there is  special call schedule_timeout(MAX_SCHEDULE_TIMEOUT) which also
>>calls schedule()
>>
>>
see kernel/sched.c



so, anyone knows what linus.t says about adding one jiffie  to every
non-zero expire?

--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
