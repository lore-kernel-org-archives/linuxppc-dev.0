Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC8E667CBE
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 22:24:14 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH] uninorth: Add module param 'aperture' for aperture size
References: <115608447678-git-send-email-> <11560844762890-git-send-email->
	<1156176559.16513.78.camel@thor.lorrainebruecke.local>
	<1156231536.21752.100.camel@localhost.localdomain>
	<1156236954.16513.141.camel@thor.lorrainebruecke.local>
	<1156285033.21752.107.camel@localhost.localdomain>
	<1159958670.23084.217.camel@thor.lorrainebruecke.local>
Date: Wed, 04 Oct 2006 14:24:08 +0200
In-Reply-To: <1159958670.23084.217.camel@thor.lorrainebruecke.local> (Michel
	=?iso-8859-1?Q?D=E4nzer's?= message of "Wed,
	04 Oct 2006 12:44:29 +0200")
Message-ID: <jelknwb76f.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Dave Jones <davej@codemonkey.org.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michel Dänzer <michel@tungstengraphics.com> writes:

> +			if (32 == values[i].size)

variable == value, please.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
