Subject: Re: I2C implementation on MPC8260
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Jos Beck <jos_beck@euronet.nl>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <4098B547.5070101@euronet.nl>
References: <4098B547.5070101@euronet.nl>
Content-Type: text/plain
Message-Id: <1083752313.15017.17.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Wed, 05 May 2004 12:18:33 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-05-05 at 11:35, Jos Beck wrote:
> Hi,
>
> I am trying to get some i2c devices (RTC, EEPROM) to run on an MPC8260
> with kernel version 2.4.21.
> I have seen some fragmented information in the kernel source
> documentation and on this mailing list, but it's not clear to me what
> parts I can use and what I have to write myself.
>
> Could anyone tell me where and how to start?

I think you need i2c-core.c, i2c-dev.c, i2c-algo-8260.c and
a driver file that set's up (board specific) i2c port settings
and irq. I think there are examples in the denx tree.
(i2c-pm826.c)

This is more or less the standard thing to do:
check the denx tree.

Jaap-Jan
>
>
> Thanks,
>
> Jos
>
>
--
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
