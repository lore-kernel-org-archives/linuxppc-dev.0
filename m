Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 4408A2BF11
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Dec 2004 03:38:44 +1100 (EST)
Date: Fri, 17 Dec 2004 09:38:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Message-ID: <20041217163837.GE31110@smtp.west.cox.net>
References: <313680C9A886D511A06000204840E1CF0A6473AF@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <313680C9A886D511A06000204840E1CF0A6473AF@whq-msgusr-02.pit.comms.marconi.com>
Cc: "'Demke, Torsten'" <Torsten.Demke@fci.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>,
	'Steven Blakeslee' <BlakesleeS@embeddedplanet.com>
Subject: Re: 2.6.10-rc3 for 8xx with I2C config enabled  still fails ...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Dec 17, 2004 at 11:30:53AM -0500, Povolotsky, Alexander wrote:

> Hi,
> 
> Even so much "touted" ;-) 2.6.10-rc3 FAILS for 8xx with I2C config enabled 
> ... and our custom MPC885 based board is using a single 24C02 type I2C
> EEPROM, connected to the I2C bus ...
> 
> Does anyone of you has any input/experience about 2.6.10-rc3 functionality
> (this all relates to our card) of:
> SPI, HDLC, Entropia, Legerity, watchdog, NAND flash support,
> MTD with JFFS2 filesystem support and flash compatibility ??? (Any info will
> be much appreciated !)

So, your best bet to get 8xx I2C working is to grab the 'latest' from a
2.4 tree that has it working, and move it up.  In doing so, you may want
to kill 'i2c-rpx' and merge it all into the i2c-algo-8xx file.

[snip]
> CONFIG_8xx=y
CONFIG_BROKEN=y
as well.  Not that it's directly relevant (the 8xx breakage is in
something else), but..

-- 
Tom Rini
http://gate.crashing.org/~trini/
