Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 5CBC82BF07
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Dec 2004 17:53:54 +1100 (EST)
Date: Thu, 23 Dec 2004 23:53:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Message-ID: <20041224065348.GA1873@smtp.west.cox.net>
References: <313680C9A886D511A06000204840E1CF0A647402@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <313680C9A886D511A06000204840E1CF0A647402@whq-msgusr-02.pit.comms.marconi.com>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: simple bootloader vs 2.6.10-rc3 for 8xx vs I2C based EEPROM ! !!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 23, 2004 at 09:32:58PM -0500, Povolotsky, Alexander wrote:
> 
> Sorry for keeping annoying with questions !
> 
> arch\ppc\8xx_io\uart.c - is it suppose to exist in 2.6.10-rc3 ?

No, it's been replaced by CONFIG_SERIAL_CPM.

> Also the question from my previous e-mail, which was not answered - does the
> simple bootloader has any debugging print statements ( prior to calling
> "load_kernel(...)" function), which I could enable ? (how ?)

No, it does not.

-- 
Tom Rini
http://gate.crashing.org/~trini/
