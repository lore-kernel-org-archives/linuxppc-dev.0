Message-ID: <3E97BB43.6030409@dgt-lab.com.pl>
Date: Sat, 12 Apr 2003 09:07:47 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel/timer.c
References: <IGEFJKJNHJDCBKALBJLLEEPEFLAA.joakim.tjernlund@lumentis.se>
In-Reply-To: <IGEFJKJNHJDCBKALBJLLEEPEFLAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>hmm, why not just:
>   expire = timespec_to_jiffies(&t);
>if tv_sec and tv_sec are zero, do you need to sleep at all?
>
>    Jocke
>
>
sleep(0) could be defined as:
-schedule to next task if there is any (just call schedule() )
-sleep minimum value (1 jiffie)

default kernel (no timer patches) uses second definition,

there is  special call schedule_timeout(MAX_SCHEDULE_TIMEOUT) which also
calls schedule()




--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
