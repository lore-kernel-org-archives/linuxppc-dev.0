Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41FC8679A6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 23:35:11 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: master branch reset
References: <17780.2568.641734.276805@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.62.0612050839120.12448@pademelon.sonytel.be>
	<528646bc0612042349t34662037nc641c8e6e2516a09@mail.gmail.com>
	<Pine.LNX.4.62.0612050901160.12448@pademelon.sonytel.be>
	<528646bc0612050015xa18b33bh4afdc2f9d196f1a1@mail.gmail.com>
	<Pine.LNX.4.62.0612051022470.20543@pademelon.sonytel.be>
	<4575463F.6070902@246tNt.com>
	<Pine.LNX.4.62.0612051157200.21116@pademelon.sonytel.be>
Date: Tue, 05 Dec 2006 13:34:57 +0100
In-Reply-To: <Pine.LNX.4.62.0612051157200.21116@pademelon.sonytel.be> (Geert
	Uytterhoeven's message of "Tue, 5 Dec 2006 11:58:45 +0100 (CET)")
Message-ID: <jeejrefrm6.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> writes:

> On Tue, 5 Dec 2006, Sylvain Munaut wrote:
>> try git pull -f -v
>
> Thanks, that worked!
>
> But as I already started recloning and the old tree had some conflicts after
> the pull -f, I just switched to the new clone.

You can always wipe the slate clean with git reset --hard, that will give
you a fresh start.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
