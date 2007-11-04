Return-Path: <hqa02330@nifty.com>
Received: from pxy2nd.nifty.com (pxy2nd.nifty.com [202.248.175.14])
	by ozlabs.org (Postfix) with SMTP id 58074DDE08
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 20:18:26 +1100 (EST)
Message-ID: <24697997.78131194167504382.hqa02330@nifty.com>
Date: Sun, 4 Nov 2007 18:11:44 +0900 (JST)
From: Komuro <hqa02330@nifty.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] pcmcia: Remove replace kio_addr_t with unsigned int
	everywhere
In-Reply-To: <20071028201858.GA10048@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
References: <20071028201858.GA10048@lixom.net>
	<20070905142742.GA1760@lixom.net>
	<20070914034854.1658a9cf.akpm@linux-foundation.org>
	<20070921221516.GA7926@lixom.net>
	<20070921233936.2aeb2504@the-village.bc.nu>
	<20070922062551.GE10625@parisc-linux.org>
	<20070922091303.GA12525@lst.de> <20071019201720.GA13234@lixom.net>
	<20071028134414.GF26943@isilmar.linta.de>
	<20071028201034.GB9472@lixom.net>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi, 

It should be "unsigned long" instead of "unsigned int".

64bit architecture uses 64bit-Memory-mapped-IO.



Best Regards
Komuro


>
>
>pcmcia: Remove replace kio_addr_t with unsigned int everywhere
>
>Remove kio_addr_t, and replace it with unsigned int. No known architecture
>needs more than 32 bits for IO addresses and ports and having a separate
>type for it is just messy.
>
>This goes on top of the patch switching the io_req_t members from ioaddr_t
>to unsigned int.
>
>
>Signed-off-by: Olof Johansson <olof@lixom.net>
>
>---
>
>On Sun, Oct 28, 2007 at 03:10:34PM -0500, Olof Johansson wrote:
>
>> This goes on top of the patch switching the io_req_t members from ioaddr_t
>> to unsigned int.
>
>Crap, I had an old version of that patch as base in my local tree when I did
>these edits. Here's a proper version.
>
>-Olof
>
