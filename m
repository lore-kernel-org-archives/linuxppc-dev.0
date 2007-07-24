Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 480F4DDE35
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 22:11:42 +1000 (EST)
Message-ID: <46A5E610.7000508@shadowen.org>
Date: Tue, 24 Jul 2007 12:44:16 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/3] ps3: Disk Storage Driver
References: <20070716161539.075822000@pademelon.sonytel.be>	<20070716162206.392129000@pademelon.sonytel.be>
	<20070718163637.3f0e0164.akpm@linux-foundation.org>
In-Reply-To: <20070718163637.3f0e0164.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alessandro Rubini <rubini@vision.unipv.it>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Jens Axboe <jens.axboe@oracle.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:

>> +	start_sector = req->sector*priv->blocking_factor;
>> +	sectors = req->nr_sectors*priv->blocking_factor;
> 
> s/*/ * /.  checkpatch missed this.

Ok, this is something we need to decide on.  Currently we only ask for
consistent spacing on all the mathematic operators.  This is mostly as
we do see a large number of non-spaced uses in defines and the like.

I am happy to expand these tests so they are always spaced on both sides
style if that is the preference.

-apw
