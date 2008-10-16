Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D665CDE06E
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 19:12:37 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: David Miller <davem@davemloft.net>
Subject: Re: powerpc allmodconfig
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<20081015.220247.262683261.davem@davemloft.net>
Date: Thu, 16 Oct 2008 09:53:32 +0200
In-Reply-To: <20081015.220247.262683261.davem@davemloft.net> (David Miller's
	message of "Wed, 15 Oct 2008 22:02:47 -0700 (PDT)")
Message-ID: <je3aixvuv7.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: netdev@vger.kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller <davem@davemloft.net> writes:

>> net/dccp/options.c: In function 'dccp_parse_options':
>> net/dccp/options.c:67: warning: 'value' may be used uninitialized in this function
>
> Known issue, not trivial to fix, gcc is just being incredibly silly here as it
> can't see all of the control flow.

Seems to be fixed in gcc 4.3.  It actually needs a pretty complete value
tracking to get right.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
