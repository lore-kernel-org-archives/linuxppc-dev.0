Date: Tue, 17 Feb 2004 15:19:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rod Boyce <rod_boyce@stratexnet.com>
Cc: Lokesh Kumar <kumar.lokesh@wrx-us.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.6 kernel ppc tree
Message-ID: <20040217221957.GH16881@smtp.west.cox.net>
References: <A3240F62EF3C2749B1A25D3BC9548F410309FE@ExchWENZ02.wenz.global.vpn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A3240F62EF3C2749B1A25D3BC9548F410309FE@ExchWENZ02.wenz.global.vpn>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Feb 18, 2004 at 10:30:41AM +1300, Rod Boyce wrote:

> I downloaded the the 2.6.1 Linux kernel and compiled it for the RPX-Lite board.  I discovered that the UART driver in arch/ppc/8xx_io/ has not been ported to the 2.6 kernel otherwise I had no problems.  I have not had time to get back to the 2.6 porting effort and update the uart.c file.  If ther eis another one out there I could try it out but that is where I left my effort.  Otherwise I would guess you may not have too many more problems but I have not been able to spend much time on this.

The linuxppc-2.5 tree already has most of this done (as it did as of
2.6.1 or 2.6.2, I haven't re-checked the drivers).  However, head_8xx.S
still needs some updates for VM/exception changes.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
