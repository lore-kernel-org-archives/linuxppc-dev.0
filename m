Message-ID: <3EA9114B.5010305@imc-berlin.de>
Date: Fri, 25 Apr 2003 12:43:23 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Wojciech Kromer <krom@dgt-lab.com.pl>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: execve inside irq?
References: <3EA90E57.8050709@dgt-lab.com.pl> <3EA90FF8.2000701@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:
>
> Wojciech Kromer schrieb:
>
>>
>> anyone knows ho to call execve inside irq
>>
>> i just want to execve("/sbin/poweroff"....) in case of pressing power
>> button on my board
>
>
> Since I did not find a better solution yet I start a new kernel thread
> that takes care of poweroff when getting the power button interrupt.
> In this new thread I then send a SIGUSR1 to init, but you could
> probably call "execve("/sbin/poweroff"....) " as well.

Of course I meant SIGUSR2. (Busybox') init powers down then...


Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
