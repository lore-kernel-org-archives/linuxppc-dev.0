Message-ID: <3C360516.5030202@mvista.com>
Date: Fri, 04 Jan 2002 11:40:06 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Liu HongXun-a16975 <a16975@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question on the pcmcia module for ppc
References: <01139FC052A0D411900B00508B9535FC048B108F@ZCH07EXM04.corp.mot.com>
Content-Type: text/plain; charset=GB2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Liu HongXun-a16975 wrote:

> Hi, all,
> I worked on the PCMCIA module for my MPC 857T based board.
> I downloaded the pcmcia-cs 3.1.29 and modified the file modules/m8xx_pcmcia.c.
> My board uses the SLOT B. What I did are just like the (F)ADS and RPXLite.
> I compiled the resulted pcmcia module and loaded them into linux kernel using "insmod".
> 1. insmod pcmcia_core.o
> 2. insmod m8xx_pcmcia.o
> 3. insmod ds.o
> Here comes the problem.
> When I inserted ds.o, the driver tells me that "cs: socket 0 timed out during reset"
> I looked through the source code and the debug info.
> I found that a lot of the same messages as follows:
> GetStatus(0) = 0x190
> ...
> Such info come from m8xx_pcmcia.c/m8xx_get_status. It seems that someone
> is not satisfied with the above return value and " get status " again and again.
> Then it quit.
>
> Any suggestions are highly appreciated!
> Thanks a lot


I'm not familiar with the 857T pcmcia, perhaps the timing is different.
 Check the timing calculation functions against the 857T UM.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
