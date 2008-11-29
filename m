Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3DC71DDDE6
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Nov 2008 02:01:58 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: roel kluin <roel.kluin@gmail.com>
Subject: Re: powerpc: hv{cs,
	si}_close() both unsigned hp->count and hvcsd->open_count cannot be
	negative
References: <4931201D.7060701@gmail.com> <jey6z24rqw.fsf@sykes.suse.de>
	<49314334.6060609@gmail.com>
Date: Sat, 29 Nov 2008 16:01:47 +0100
In-Reply-To: <49314334.6060609@gmail.com> (roel kluin's message of "Sat, 29
	Nov 2008 08:27:16 -0500")
Message-ID: <jetz9q4lus.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

roel kluin <roel.kluin@gmail.com> writes:

> Andreas Schwab wrote:
>> roel kluin <roel.kluin@gmail.com> writes:
>> 
>>> -	if (--hvcsd->open_count == 0) {
>>> +	if (hvcsd->open_count == 1) {
>>> +		hvcsd->open_count--;
>> 
>> This is not the same.
>
> I think you're missing that I also decrement if (hvcsd->open_count > 1)

Yes, sorry, I missed that.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
