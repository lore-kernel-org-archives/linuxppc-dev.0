Content-Type: text/plain;
  charset="iso-8859-1"
From: Leonardo Pereira Santos <lsantos@pd3.com.br>
To: xiaogeng_jin@agilent.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to halt m8xx?
Date: Wed, 29 Jan 2003 10:21:30 -0200
References: <9153F74610B7D311B83900902771C871124D9396@axcs07.cos.agilent.com>
In-Reply-To: <9153F74610B7D311B83900902771C871124D9396@axcs07.cos.agilent.com>
MIME-Version: 1.0
Message-Id: <200301291021.38490.lsantos@pd3.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



How about power down mode? From the 8xx manual:
"Power down mode can be used for:
	- A software initiated controlled shutdown, with optional automatic wakeup,
	- (...) "

Isn't what you want?
Check page 14-24.

On Tuesday 28 January 2003 22:00, xiaogeng_jin@agilent.com wrote:
> Hi,
>
> I found that in m8xx the halt function is the same as the restart function
> because m8xx_halt() just calls m8xx_restart() in m8xx_setup.c. If I just
> want to halt the m8xx system but not to restart it automatically, what
> should I do? Set a few registers and wait for ever? THanks for your
> thoughts.
>
> Regards,
>
> - Shawn.
>

- --
This is Linux country.
On a quiet night, you can hear Windows reboot.

Leonardo Pereira Santos
Engenheiro de Projetos
PD3 Tecnologia
av. Pará 330/202
(51) 3337 1237

Today Fortune tells us:
The problem with graduate students, in general, is that they have
to sleep every few days.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
