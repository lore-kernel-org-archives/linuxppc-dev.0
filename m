Message-Id: <sba9d49a.021@mail.frequentis.com>
Date: Thu, 20 Sep 2001 11:35:37 +0200
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <wd@denx.de>, <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC860(T) uart SCCs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for info. Well in a quick and dirty manner the uart device driver now runs, but now nothing will work no SCC. I adapt the code that I set the ports manualy, also disable serial console and hardware flow. But perhaps I can find in that way my bug.

best regards
Gerhard

>>> Wolfgang Denk <wd@denx.de> 09/20/01 09:28 AM >>>

Hi,

> Iwork with an custom board MPC860T kernel 2.4.5. I will use all 4 SCC as uart RS485/RS232. The problem is, that SCC1 and SCC2 works fine and SCC3 and SCC4 not:

See our kernel version on ftp://ftp.denx.de/pub/LinuxPPC/usr/src .
The uart driver included works on all 6 possible serial ports (2 x SMC,
4 x SCC) simultaneous, with support for hardware flow controll on all
4 SCC ports.

I've sent a patch for current kernel versions (2.4.10-pre?) to Tom Rini
several days ago. Don't know when it will make it into the official
source tree, if ever.

Wolfgang Denk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
