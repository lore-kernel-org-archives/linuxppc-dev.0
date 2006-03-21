Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41CF767A5A
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 05:32:49 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 8/11] powerpc: Add strne2a() to convert a string from
	EBCDIC to ASCII
References: <1142934351.193140.181086235013.qpush@concordia>
	<20060321094637.C86EE67BBB@ozlabs.org>
	<20060321181105.GA5248@pb15.lixom.net>
Date: Tue, 21 Mar 2006 19:32:39 +0100
In-Reply-To: <20060321181105.GA5248@pb15.lixom.net> (Olof Johansson's message
	of "Tue, 21 Mar 2006 12:11:05 -0600")
Message-ID: <je64m7sl6g.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson <olof@lixom.net> writes:

> Why iterate over the string twice? Why not do 
> 	for (..; i < n && src[n]; ...)

ITYM i < n && src[i].

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
