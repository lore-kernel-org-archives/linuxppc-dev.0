Message-ID: <3905C8E4.98081DBB@embeddededge.com>
Date: Tue, 25 Apr 2000 12:33:40 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Kim Jørgensen <KIJ@infocom.dk>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with serial ports
References: <819E3E914E0AD11194DE00805F0D100B0138B83C@fbi.infocom.dk>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kim Jørgensen wrote:

> Linux runs fine on the board using smc1 as console, but I can't receive or
> transmit anything on smc2 and scc2.

The SCC2 is used for Ethernet, and SMC2 is probably reserved for the
Embedded Planet TDM audio codec.  If you don't use Ethernet, you can
enable SCC2 for serial use.  You have to manually edit the
arch/ppc/8xx_io/uart.c port table.  I am working on a configurable
version, just haven't found anything terribly fool-proof yet.  I also
have a very different new driver I am testing for the uart.


> Btw. There is a problem in m8xx_cpm_setbrg in commproc.c. I can't set any
> serial port to run any lower than 1200 baud.

OK......You are the first to ask :-).  I'll check this into the code.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
