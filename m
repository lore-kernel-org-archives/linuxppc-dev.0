Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02FD967A44
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 08:06:46 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: snd-aoa status update / automatic driver loading
References: <1147860564.14395.6.camel@johannes>
	<20060517215412.GA4504@localhost> <20060517221945.GA2902@localhost>
	<1147947192.15507.40.camel@johannes> <20060518181748.GA2836@localhost>
Date: Fri, 19 May 2006 00:06:37 +0200
In-Reply-To: <20060518181748.GA2836@localhost> (Wolfgang Pfeiffer's message of
	"Thu, 18 May 2006 20:17:48 +0200")
Message-ID: <je3bf7oumq.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Pfeiffer <roto@gmx.net> writes:

> BTW: Is there a way to let 'alsaconf' detect the soundcard on this
> PB5,8 ?

AFAIK, alsaconf has only support for probing PCI and ISA sound cards, but
the AOA sound is hidden behind an i2s bus that is hidden behind a mac-io
bus.  The version included in SuSE has hardcoded special cases for Sparc
and PPC.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
