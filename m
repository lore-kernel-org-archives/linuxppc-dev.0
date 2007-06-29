Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D648DE032
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 01:25:13 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] dtc: Add install makefile target
References: <1183128803.30145.29.camel@weaponx.rchland.ibm.com>
Date: Fri, 29 Jun 2007 17:24:51 +0200
In-Reply-To: <1183128803.30145.29.camel@weaponx.rchland.ibm.com> (Josh Boyer's
	message of "Fri\, 29 Jun 2007 09\:53\:23 -0500")
Message-ID: <jehcoqsrzw.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer <jwboyer@linux.vnet.ibm.com> writes:

> +install: dtc ftdump
> +	$(INSTALL) -d $(DESTDIR)/$(BINDIR)
> +	$(INSTALL) -m 755 dtc $(DESTDIR)/$(BINDIR)
> +	$(INSTALL) -m 755 ftdump $(DESTDIR)/$(BINDIR)

Don't put a slash after $(DESTDIR).  You'll end up with a doulbe slash.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
