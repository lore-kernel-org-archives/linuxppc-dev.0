To: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC860(T) uart SCCs 
In-Reply-To: Your message of "Tue, 18 Sep 2001 13:02:06 +0200."
             <sba745ea.073@mail.frequentis.com>
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 20 Sep 2001 09:23:56 +0200
From: Wolfgang Denk <wd@denx.de>
Message-Id: <20010920072402.0C0991009C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
