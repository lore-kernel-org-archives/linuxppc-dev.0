Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 0AD772BF13
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Dec 2004 10:13:08 +1100 (EST)
Date: Thu, 23 Dec 2004 16:13:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Message-ID: <20041223231307.GT15219@smtp.west.cox.net>
References: <313680C9A886D511A06000204840E1CF0A647400@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <313680C9A886D511A06000204840E1CF0A647400@whq-msgusr-02.pit.comms.marconi.com>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: simple bootloader vs 2.6.10-rc3 for 8xx vs I2C based EEPROM !!!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 23, 2004 at 05:21:46PM -0500, Povolotsky, Alexander wrote:

> Hi,
> 
> Would below (from Dan Malek) explain why on my 8xx board with I2C EEPROM
> (which ptobably does not work on 2.6.10-rc3) the simple bootloader fails to
> load the kernel ?

If the board you've selected does not have any meaningful functions in
embed_config.c, yes, it probably would.  If this is a custom board, or
something not otherwise supported by the standard kernel, it sounds like
some other parts of your 2.4 code, under arch/ppc/boot/ have not been
ported over yet.

-- 
Tom Rini
http://gate.crashing.org/~trini/
