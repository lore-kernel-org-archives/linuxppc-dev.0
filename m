Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id CC712DDE06
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 22:27:41 +1000 (EST)
Date: Fri, 13 Jul 2007 14:27:52 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: PS3 Storage Driver O_DIRECT issue
Message-ID: <20070713122752.GA854@aepfle.de>
References: <20070704132212.726923000@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070704132212.726923000@pademelon.sonytel.be>
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J.  Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, Alessandro Rubini <rubini@ipvvis.unipv.it>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This driver (or the generic PS3 code) has appearently problems with
O_DIRECT. 
glibc aborts parted because the malloc metadata get corrupted. While it
is reproducible, the place where it crashes changes with every version
of the debug attempt.
I dont have a handle right now, all I know is that the metadata after a
malloc area get overwritten with zeros.


Can you have a look at this? 
parted /dev/ps3da
print (a few times)
