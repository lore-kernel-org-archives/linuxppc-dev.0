From: xiaogeng_jin@agilent.com
Message-ID: <9153F74610B7D311B83900902771C871124D9398@axcs07.cos.agilent.com>
To: lsantos@pd3.com.br, linuxppc-embedded@lists.linuxppc.org
Subject: RE: how to halt m8xx?
Date: Wed, 29 Jan 2003 12:30:24 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> How about power down mode? From the 8xx manual:
> "Power down mode can be used for:
> 	- A software initiated controlled shutdown, with
> optional automatic wakeup,
> 	- (...) "
>
> Isn't what you want?
> Check page 14-24.
Hmmm...probably not. I figured out that the reason why HALT and REBOOT behave exactly the same is because m8xx_halt() calls m8xx_restart(). So now I just changed m8xx_halt() to a forever loop, which fulfills my purpose.

THanks for your time.

- Shawn.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
