Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10BE1DDD0E
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 08:54:23 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Nvidiafb broken in 2.6.21-rc1
References: <jezm737pxc.fsf@sykes.suse.de>
	<1172484121.5824.1.camel@localhost.localdomain>
Date: Mon, 26 Feb 2007 22:54:06 +0100
In-Reply-To: <1172484121.5824.1.camel@localhost.localdomain> (Richard Purdie's
	message of "Mon, 26 Feb 2007 10:02:01 +0000")
Message-ID: <jer6sc60w1.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Richard Purdie <rpurdie@rpsys.net> writes:

> Thanks, I think I know what the problem is. Could you try this change
> please:

Thanks, that fixes the problem.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
