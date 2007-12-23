Return-Path: <lu_zero@gentoo.org>
Message-ID: <476E9781.1070204@gentoo.org>
Date: Sun, 23 Dec 2007 18:14:41 +0100
From: Luca Barbato <lu_zero@gentoo.org>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Cbe-oss-dev] Time for cell code reshuffle?
References: <200712211522.03841.arnd@arndb.de>	<200712231247.44154.jk@ozlabs.org>
	<20071223123501.GA19823@lst.de>
	<Pine.LNX.4.62.0712231506050.17187@chinchilla.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0712231506050.17187@chinchilla.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> On Sun, 23 Dec 2007, Christoph Hellwig wrote:
>> Strong NACK for fs/spufs/  fs code is the smallest part of the spu
>> support, and all this nasty lowlevel code doesn't belong into fs/ at
>> all.
> 
> drivers/spu/?
> 

arch/spu/?

-- 

Luca Barbato
Gentoo Council Member
Gentoo/linux Gentoo/PPC
http://dev.gentoo.org/~lu_zero
