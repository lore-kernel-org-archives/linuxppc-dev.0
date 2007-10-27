Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	by ozlabs.org (Postfix) with ESMTP id 7B8B9DDE9B
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 21:34:41 +1000 (EST)
Date: Sat, 27 Oct 2007 13:34:36 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] compat_ioctl: fix block device compat ioctl regression
Message-ID: <20071027113435.GG8875@kernel.dk>
References: <47221F91.60401@overt.org> <200710270051.38748.arnd@arndb.de>
	<47228A9E.80505@overt.org> <200710271138.06456.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200710271138.06456.arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>, akpm@linux-foundation.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Philip Langdale <philipl@overt.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 27 2007, Arnd Bergmann wrote:
> From: Philip Langdale <philipl@overt.org>
> The conversion of handlers to compat_blkdev_ioctl accidentally
> disabled handling of most ioctl numbers on block devices because
> of a typo. Fix the one line to enable it all again.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> Mea Culpa. This should have been found by my testing, as it's clear
> that most of my big patch never worked at all. Sorry for causing
> problems for everyone involved here.
> 
> I'm attributing the patch to Philip, as he's the one who pointed
> out to me what the fix is.

Oops, added for swift inclusion.

-- 
Jens Axboe
