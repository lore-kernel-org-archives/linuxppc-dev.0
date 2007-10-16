Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F10C5DDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 08:29:47 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] bootwrapper: Allow wrapper script to execute verbosely
References: <20071016213101.14117.43657.stgit@trillian.cg.shawcable.net>
Date: Wed, 17 Oct 2007 00:29:36 +0200
In-Reply-To: <20071016213101.14117.43657.stgit@trillian.cg.shawcable.net>
	(Grant Likely's message of "Tue\, 16 Oct 2007 15\:31\:01 -0600")
Message-ID: <jeejfuae27.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely <grant.likely@secretlab.ca> writes:

> +# Allow for verbose output
> +if [ "$V" == "1" ]; then

The correct syntax is [ a = b ] (and the quotes around 1 are not needed,
btw.).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
