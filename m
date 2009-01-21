Return-Path: <phillip@lougher.demon.co.uk>
Received: from lon1-post-1.mail.demon.net (lon1-post-1.mail.demon.net
	[195.173.77.148]) by ozlabs.org (Postfix) with ESMTP id 282B6DDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 23:36:30 +1100 (EST)
Message-ID: <497715AA.1070701@lougher.demon.co.uk>
Date: Wed, 21 Jan 2009 12:31:38 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
MIME-Version: 1.0
To: Eric Sesterhenn <snakebyte@gmx.de>
Subject: Re: [Patch] NULL pointer deref with corrupted squashfs image
References: <20090113124027.GB16333@alice> <20090116174525.GA31869@alice>
	<20090116190725.GA19453@logfs.org>
	<20090116230700.GP6710@smtp.west.cox.net>
	<20090117134916.GA29641@logfs.org> <20090120163957.GA21339@alice>
	<20090120184702.GB30203@smtp.west.cox.net>
	<20090121083418.GA5865@alice>
In-Reply-To: <20090121083418.GA5865@alice>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Tom Rini <trini@kernel.crashing.org>, chris@zankel.net,
	=?UTF-8?B?SsO2cm4gRW5nZWw=?= <joern@logfs.org>,
	linuxppc-dev@ozlabs.org, rpurdie@rpsys.net, linux-fsdevel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eric Sesterhenn wrote:

> Some callers of zlib_inflate() might accidentally pass a NULL
> pointer in strm->next_out which zlib_inflate() should catch.
> Others like the powerpc gunzip_partial expect to be able
> to extract a zImage to memory location 0. This introduces
> zlib_inflate_usafe() for those and adds a check for the rest
> 
> 
> +    These two wrappers decide wheter strm->next_out gets checked for NULL.

"wheter" -> "whether"

Apart from that looks OK to me.

Phillip
