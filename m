Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9AF4E67A00
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 08:59:43 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: DTC/dts modifications
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
	<1146512012.24239.28.camel@cashmere.sps.mot.com>
	<695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
	<1146512732.24239.34.camel@cashmere.sps.mot.com>
	<55FD11DB-54AF-4284-9E9A-C313F4232105@kernel.crashing.org>
	<20060501150728.04694488.kim.phillips@freescale.com>
	<00CD15B8-F448-4985-8EEC-3BBF61C0110B@kernel.crashing.org>
Date: Tue, 02 May 2006 00:59:25 +0200
In-Reply-To: <00CD15B8-F448-4985-8EEC-3BBF61C0110B@kernel.crashing.org> (Kumar
	Gala's message of "Mon, 1 May 2006 15:28:34 -0500")
Message-ID: <jehd49s65u.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala <galak@kernel.crashing.org> writes:

> Cool, here's an invocation that seems to work well.  Not sure what  
> causes linux = 1 (thus I need the -U linux).  Also address the line  
> information that is normally spit out.
>
> cpp -U linux -P -x assembler-with-cpp foo.dts

Try -undef, that removes all pre-defined macros.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
