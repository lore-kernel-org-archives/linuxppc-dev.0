Subject: Re: Linux on Force Computers CPCI-3750 eth drivers
From: luca gambazzi <luca.gambazzi@epfl.ch>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030329154326.GE5343@ip68-0-152-218.tc.ph.cox.net>
References: <1048949739.5125.126.camel@shampoo.epfl.ch>
	 <20030329154326.GE5343@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1049456953.14675.53.camel@shampoo.epfl.ch>
Mime-Version: 1.0
Date: 04 Apr 2003 13:49:13 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

i'm still trying to bild a running linux kernel for a Force Computers
CPCI-3750.

I've got one more error, the ethernet card doesn't work.
is a Digital DS21143 Tulip

i've installed the kernel drivers (i've tried with 2.4 and 2.5
penguinppc kernel tree), and the drivers found in
http://sourceforge.net/projects/tulip, but the error is always the same.

NETDEV WATCHDOG: eth0: transmit timed out

here can you find a bootlog (kernelboot.txt), the tcpdump on my pc, and
the .config file I used in this case (config_2_5_66.txt)

http://lsa1pc32.epfl.ch/~gamba/robox/

Maybe somebody has experence with this kind of error and can help me.

Thanks a lot
Luca Gambazzi

PS Tom: I don't find the .config file who caused the crash I've posted
last week, i'll search in my pc, sorry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
