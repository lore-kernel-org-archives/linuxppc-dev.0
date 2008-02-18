Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2ED31DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 04:37:48 +1100 (EST)
Date: Mon, 18 Feb 2008 20:37:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Valdis.Kletnieks@vt.edu
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign
	endianness
Message-ID: <20080218173745.GA25628@localhost.localdomain>
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
	<19805.1203355811@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <19805.1203355811@turing-police.cc.vt.edu>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Krzysztof Helt <krzysztof.h1@poczta.fm>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 18, 2008 at 12:30:11PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 18 Feb 2008 08:18:47 +0100, Krzysztof Helt said:
> > I know two fb drivers which use endianess information (pm2fb and s3c2410fb).
> > Both resolve endianess at driver level. Actually, both handle it by setting special
> > bits so the graphics chip itself reorder bytes to transform foreign endianess. 
> > I understand that this patch is for chips which cannot reorder bytes by themselves.
> 
> Does anybody know of such a chip that's actually available in the wild?

LE Fujitsu mb86277 (MINT) on the BE MPC8360E.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
