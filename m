Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F92A67B85
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 02:15:02 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Frank van Maarseveen <frankvm@frankvm.com>
References: <20050629145013.GA21494@janus>
Date: Wed, 29 Jun 2005 18:14:52 +0200
In-Reply-To: <20050629145013.GA21494@janus> (Frank van Maarseveen's message of
	"Wed, 29 Jun 2005 16:50:13 +0200")
Message-ID: <jehdfhnnr7.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: include/asm-ppc/atomic.h: fluff in inline assembly code?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Frank van Maarseveen <frankvm@frankvm.com> writes:

> What is the point of all those v->counter arguments?

It tells the compiler that v->counter is changed by the asm.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
