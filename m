Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7DE99DDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 03:10:18 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] autodetect serial console on efika
References: <20070331150823.GA25421@aepfle.de>
	<20080121152900.GA8664@aepfle.de>
Date: Mon, 21 Jan 2008 17:09:45 +0100
In-Reply-To: <20080121152900.GA8664@aepfle.de> (Olaf Hering's message of "Mon\,
	21 Jan 2008 16\:29\:00 +0100")
Message-ID: <jelk6jp3cm.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering <olaf@aepfle.de> writes:

> +/*
> + * Per default, input/output-device points to keyboard/screen
> + * If no card is installed, the built-in serial port is used as a fallback.
> + * But unfortunately, the firmware does not connect /chosen/{stdin,stdout}
> + * the the built-in serial node. Instead, a /failsafe node is created.

s/the the/to the/

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
