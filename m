Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 07E44DDEDD
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 02:44:08 +1100 (EST)
Message-ID: <47BC4AAE.8020908@anagramm.de>
Date: Wed, 20 Feb 2008 16:43:42 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign
	endianness
References: <20080205154432.GA8749@localhost.localdomain>	<20080214224942.a0cb6218.akpm@linux-foundation.org>	<20080215164542.GB16810@localhost.localdomain>	<Pine.LNX.4.64.0802171030330.6848@anakin>	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>	<19805.1203355811@turing-police.cc.vt.edu>	<47BA162C.5000807@anagramm.de>
	<1203381353.6740.59.camel@pasglop>	<47BABD3A.7010102@anagramm.de>	<20080219040530.7b1d115d.akpm@linux-foundation.org>
	<18363.31427.989835.105966@cargo.ozlabs.ibm.com>
In-Reply-To: <18363.31427.989835.105966@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: adaplas@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
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

Paul Mackerras schrieb:
> Andrew Morton writes:
> 
>> Bizarrely, the original author of the patch (Anton) has fallen off the cc. 
>> Could whoever did that please thwap himself?
>>
>> Anyway, my head is now officially spinning.  Did anyone actually have a
>> reason why we shouldn't proceed with Anton's patch?
> 
> I was wondering if it would be sufficient to provide alternative
> versions of fb_readl, fb_writel etc. that do byte-swapping.  That
> would mean that all framebuffers would have to have the same
> endianness, but that would suffice for embedded systems such as
> Anton's and would end up a lot simpler IMHO.

Yes. At least the affected PowerPC platforms can do byte-swapping on
the fly, so this should be sufficient and without performance
penalty, AFAICS.

Regards,

Clemens
