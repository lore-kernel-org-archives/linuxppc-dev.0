Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ABF36DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Dec 2006 23:41:25 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.20-rc2: kernel BUG at include/asm/dma-mapping.h:110!
References: <je7iwa1l8a.fsf@sykes.suse.de>
	<1167429171.23340.125.camel@localhost.localdomain>
	<tkrat.f159c58fec599d72@s5r6.in-berlin.de>
Date: Sat, 30 Dec 2006 13:41:16 +0100
In-Reply-To: <tkrat.f159c58fec599d72@s5r6.in-berlin.de> (Stefan Richter's
	message of "Fri, 29 Dec 2006 23:47:04 +0100 (CET)")
Message-ID: <jehcvdo8sz.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux1394-devel@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Richter <stefanr@s5r6.in-berlin.de> writes:

> The parent device of my bogus fw-host device should do the trick. Alas I
> can't test on ppc64 or with anything else than ohci1394 driven
> controllers...

Successfully tested on ppc64.

Thanks, Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
