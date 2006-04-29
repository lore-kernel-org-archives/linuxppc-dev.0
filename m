Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8070679E6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 23:46:18 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: sign extension for 32bit syscalls on ppc64
References: <20060428131254.GA507@lst.de>
	<17490.42497.351114.712494@cargo.ozlabs.ibm.com>
	<20060429113059.150cadd6.sfr@canb.auug.org.au>
	<17490.53377.898206.21369@cargo.ozlabs.ibm.com>
	<20060429131640.6f79e0d3.sfr@canb.auug.org.au>
Date: Sat, 29 Apr 2006 15:46:11 +0200
In-Reply-To: <20060429131640.6f79e0d3.sfr@canb.auug.org.au> (Stephen
	Rothwell's message of "Sat, 29 Apr 2006 13:16:40 +1000")
Message-ID: <jezmi4xzoc.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Has any testing been done on these interfaces that involves 32 bit
> processes passing AT_FDCWD on 64 bit kernels (I realise that it will work
> for some architectures but I suspect not ppc64).

Appears to work fine for me (tested with openat).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
