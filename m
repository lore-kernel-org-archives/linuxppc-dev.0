Message-ID: <3D255F86.4060206@cambridgebroadband.com>
Date: Fri, 05 Jul 2002 09:57:42 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: "Kappl, Hannes" <hkappl@harris.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: set a limit for the cache
References: <8D4C69676E66D511A1CB00508BBBB1922C4173@ranmx1.ran.harris.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kappl, Hannes wrote:

>  Hi,
>
>  I am using kernel 2.4.4. I have 32M RAM with a 10M Ramdisk. Now my problem is
> that
>  the Ramdisk is cached in the RAM(4 - 8M!). Is it possible to set the size of
> the
>  cache to a limit or to disable the cache complete?
>
>
>
>    7:13pm  up 34 min,  0 users,  load average: 0.12, 0.33, 0.30
>  22 processes: 21 sleeping, 1 running, 0 zombie, 0 stopped
>  CPU states:  0.9% user,  4.3% system,  0.0% nice, 94.7% idle
>  Mem:   30612K av,   9216K used,  21396K free,   9904K shrd,      0K buff
>  Swap:      0K av,      0K used,      0K free                  5392K cached
>
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
>   107 root      14   0   836  836   644 R       0  4.5  2.7   0:00 top
>



I'm confused, top says that you have 21.4M free.  If your 10M ramdisk was being cached in 4M of RAM
then surely you'd have at most (32-14)=18M free?

While we're on the topic of RAM usage, can anyone tell me how you find out how the shrd memory (see
top output above) is broken down into seperate libraries.

Thanks,

Alex

>
>  best regard
>  Hannes
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
