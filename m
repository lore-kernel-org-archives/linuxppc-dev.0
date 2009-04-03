Return-Path: <axboe@kernel.dk>
Date: Fri, 3 Apr 2009 20:03:17 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] ps3vram: Replace mutex by spinlock + list
Message-ID: <20090403180317.GB5178@kernel.dk>
References: <1238763938-7076-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1238763938-7076-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1238763938-7076-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1238763938-7076-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238763938-7076-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 03 2009, Geert Uytterhoeven wrote:
> Remove the mutex serializing access to the cache.
> Instead, queue up new requests on a list if the driver is busy.
> 
> This improves sequential write performance by ca. 2%.

Great, precisely the method I wanted to see there! I've added your three
patches, thanks Geert.


-- 
Jens Axboe
