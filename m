Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id AAE322BF11
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Dec 2004 13:33:14 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647402@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
	"'dan@embeddededge.com'" <dan@embeddededge.com>
Date: Thu, 23 Dec 2004 21:32:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: RE: simple bootloader vs 2.6.10-rc3 for 8xx vs I2C based EEPROM ! !!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Sorry for keeping annoying with questions !

arch\ppc\8xx_io\uart.c - is it suppose to exist in 2.6.10-rc3 ?

I do not have it ...

(I used
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.10-rc3.tar.bz2
- is it correct ?)

If uart.c is functionally not suppose to be in 2.6.10-rc3 (but I do clearly
see it in 2.6.8 ) 
where its code went to ?

Also the question from my previous e-mail, which was not answered - does the
simple bootloader has any debugging print statements ( prior to calling
"load_kernel(...)" function), which I could enable ? (how ?)

Thanks,
Alex

PS Happy Holidays !
-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Thursday, December 23, 2004 6:13 PM
To: Povolotsky, Alexander
Cc: 'dan@embeddededge.com'; 'linuxppc-embedded@ozlabs.org'
Subject: Re: simple bootloader vs 2.6.10-rc3 for 8xx vs I2C based EEPROM
!!!


On Thu, Dec 23, 2004 at 05:21:46PM -0500, Povolotsky, Alexander wrote:

> Hi,
> 
> Would below (from Dan Malek) explain why on my 8xx board with I2C EEPROM
> (which ptobably does not work on 2.6.10-rc3) the simple bootloader fails
to
> load the kernel ?

If the board you've selected does not have any meaningful functions in
embed_config.c, yes, it probably would.  If this is a custom board, or
something not otherwise supported by the standard kernel, it sounds like
some other parts of your 2.4 code, under arch/ppc/boot/ have not been
ported over yet.

-- 
Tom Rini
http://gate.crashing.org/~trini/
