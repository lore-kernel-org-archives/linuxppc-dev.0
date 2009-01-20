Return-Path: <joern@logfs.org>
Received: from longford.logfs.org (lazybastard.de [212.112.238.170])
	by ozlabs.org (Postfix) with ESMTP id B969FDDF4C
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 05:28:26 +1100 (EST)
Date: Tue, 20 Jan 2009 18:57:39 +0100
From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
To: Eric Sesterhenn <snakebyte@gmx.de>
Subject: Re: [Patch] NULL pointer deref with corrupted squashfs image
Message-ID: <20090120175739.GA4816@logfs.org>
References: <20090113124027.GB16333@alice> <20090116174525.GA31869@alice>
	<20090116190725.GA19453@logfs.org>
	<20090116230700.GP6710@smtp.west.cox.net>
	<20090117134916.GA29641@logfs.org> <20090120163957.GA21339@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090120163957.GA21339@alice>
Cc: Tom Rini <trini@kernel.crashing.org>, chris@zankel.net,
	phillip@lougher.demon.co.uk, linuxppc-dev@ozlabs.org,
	rpurdie@rpsys.net, linux-fsdevel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 20 January 2009 17:47:14 +0100, Eric Sesterhenn wrote:
> 
> Some callees of zlib_inflate() might accidentally pass a NULL

s/callee/caller/ ?

Apart from this, looks fine to me - modulo xtensa of course.

Jörn

-- 
Sometimes, asking the right question is already the answer.
-- Unknown
