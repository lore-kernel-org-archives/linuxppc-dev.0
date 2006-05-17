Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA90A679EA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 05:53:26 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa status update / automatic driver loading
References: <1147860564.14395.6.camel@johannes>
Date: Wed, 17 May 2006 21:53:21 +0200
In-Reply-To: <1147860564.14395.6.camel@johannes> (Johannes Berg's message of
	"Wed, 17 May 2006 12:09:24 +0200")
Message-ID: <jey7x04edq.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> Hey,
>
> Currently snd-aoa is known to work on the following machines:
> * PowerBook5,8
> * PowerBook5,7
> * PowerMac8,1
> * PowerMac8,2
> * 17" October 2005 PowerBook (don't know the number)
> * PowerMac11,2
> * PowerBook6,8
> and my
> * PowerBook5,6

For PowerBook6,7:

	/* PowerBook6,7 */
	{ .layout_id = 92,
	  .codecs[0] = {
		.name = "tas",
		.connections = tas_connections_nolineout,
	  },
	},

Appears to work fine, apart from the missing features.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
