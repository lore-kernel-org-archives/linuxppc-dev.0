Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 51810B6FBC
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2012 22:15:22 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 10/15] powerpc: fixes for instructions not using correct
 register naming
References: <1339155365.316308.981577666228.qpush@ale>
 <20120608113605.91B88D43B2F__24549.446340143$1339156128$gmane$org@localhost.localdomain>
Date: Fri, 08 Jun 2012 14:15:14 +0200
In-Reply-To: <20120608113605.91B88D43B2F__24549.446340143$1339156128$gmane$org@localhost.localdomain>
 (Michael Neuling's message of "Fri, 08 Jun 2012 21:36:05 +1000")
Message-ID: <m2sje6t2y5.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

>  	/* Invalidate all TLBs */
> -	PPC_TLBILX_ALL(0,0)
> +	PPC_TLBILX_ALL(R0,R0)

The first argument is (RA|0), so 0 is zero, not r0.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
