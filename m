Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id B4B24DDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 10:35:28 +1100 (EST)
Message-ID: <47BA162C.5000807@anagramm.de>
Date: Tue, 19 Feb 2008 00:35:08 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for
	foreign	endianness
References: <20080205154432.GA8749@localhost.localdomain>	<20080214224942.a0cb6218.akpm@linux-foundation.org>	<20080215164542.GB16810@localhost.localdomain>	<Pine.LNX.4.64.0802171030330.6848@anakin>	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
	<19805.1203355811@turing-police.cc.vt.edu>
In-Reply-To: <19805.1203355811@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: adaplas@gmail.com, Krzysztof Helt <krzysztof.h1@poczta.fm>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valdis.Kletnieks@vt.edu schrieb:
> On Mon, 18 Feb 2008 08:18:47 +0100, Krzysztof Helt said:
>> I know two fb drivers which use endianess information (pm2fb and s3c2410fb).
>> Both resolve endianess at driver level. Actually, both handle it by setting special
>> bits so the graphics chip itself reorder bytes to transform foreign endianess. 
>> I understand that this patch is for chips which cannot reorder bytes by themselves.
> 
> Does anybody know of such a chip that's actually available in the wild?  Or are
> we writing drivers for speculative possible chips?
> 

I had troubles with the Silicon Motion SM501/SM502 endianess on PowerPC PCI vs. LocalBus.
The chip also has a register to swap endianess, but that seems to only affect some
LocalBus modes.
The current fb and X drivers are working, but when it comes to font
aliasing and hw-acceleration, the problems start to rise again...

Regards,

Clemens
