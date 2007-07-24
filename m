Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CAF27DDEA0
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 22:52:39 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/3] ps3: Disk Storage Driver
References: <20070716161539.075822000@pademelon.sonytel.be>
	<20070716162206.392129000@pademelon.sonytel.be>
	<20070718163637.3f0e0164.akpm@linux-foundation.org>
	<46A5E610.7000508@shadowen.org> <46A5F275.7060905@garzik.org>
Date: Tue, 24 Jul 2007 14:52:32 +0200
In-Reply-To: <46A5F275.7060905@garzik.org> (Jeff Garzik's message of "Tue\, 24
	Jul 2007 08\:37\:09 -0400")
Message-ID: <je3aze6k1b.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>,
	linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@vision.unipv.it>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff Garzik <jeff@garzik.org> writes:

> Andy Whitcroft wrote:
>> Andrew Morton wrote:
>> 
>>>> +	start_sector = req->sector*priv->blocking_factor;
>>>> +	sectors = req->nr_sectors*priv->blocking_factor;
>>> s/*/ * /.  checkpatch missed this.
>> 
>> Ok, this is something we need to decide on.  Currently we only ask for
>> consistent spacing on all the mathematic operators.  This is mostly as
>> we do see a large number of non-spaced uses in defines and the like.
>> 
>> I am happy to expand these tests so they are always spaced on both sides
>> style if that is the preference.
>
> That is most definitely the preference:  spaces surround operators.
                                                          ^binary

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
