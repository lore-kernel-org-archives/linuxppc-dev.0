Message-ID: <398EF507.AA56B9FF@mvista.com>
Date: Mon, 07 Aug 2000 10:42:31 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C,SPI and QMC
References: <819E3E914E0AD11194DE00805F0D100B0138B86C@fbi.infocom.dk> <398EE632.D9A867E@vas-gmbh.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Przybylski wrote:
>
> Hi all,
> I plan to use QMC on SCC1 plus SPI on a MPC855T / 860DT for an ISDN BRI
> implementation. I also need I2C for other purposes.
> Following the QMCSUPPLEMENT/AD manual from Motorola I found that one looses
> either I2C using SCC1 for QMC/Ethernet or SPI using SCC2 for QMC/Ethernet.
> I hoped that the I2C/SPI micro code patch would do the trick. But scanning this
> mailing list archive I got aware of troubles with this, or even worse that the
> patch has been removed from the kernel.
> So my question goes like this:
>  has anybody managed to use I2C, SPI and QMC on SCC1 altogether, or am I lost
> without any hope?
>

I have successfully used SPI with ethernet on SCC2 with the microcode
patch. However, I did that on a 823, I haven't tried it on the 855/860.
I think I have used the i2c driver with the microcode patch on a 860,
but don't quote me.  This was all on the Embedded Planet boards.


Matthew Locke
Montavista Software
http://www.mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
