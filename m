Message-ID: <3EA9197A.6020302@dgt-lab.com.pl>
Date: Fri, 25 Apr 2003 13:18:18 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: execve inside irq?
References: <3EA90E57.8050709@dgt-lab.com.pl> <3EA90FF8.2000701@imc-berlin.de>
In-Reply-To: <3EA90FF8.2000701@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Since I did not find a better solution yet I start a new kernel thread
> that takes care of poweroff when getting the power button interrupt.
> In this new thread I then send a SIGUSR1 to init, but you could
> probably call "execve("/sbin/poweroff"....) " as well.
>
> Steven
>
>
thx, this method works fine


--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
