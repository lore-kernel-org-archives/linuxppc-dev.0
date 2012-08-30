Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9485E2C01FF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2012 01:25:30 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Moving target
References: <503F7555.5060404__42569.4412122995$1346339823$gmane$org@lpsc.in2p3.fr>
Date: Thu, 30 Aug 2012 17:25:24 +0200
In-Reply-To: <503F7555.5060404__42569.4412122995$1346339823$gmane$org@lpsc.in2p3.fr>
 (Guillaume Dargaud's message of "Thu, 30 Aug 2012 16:14:45 +0200")
Message-ID: <m2r4qos8pn.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guillaume Dargaud <dargaud@lpsc.in2p3.fr> writes:

> I don't understand the part about address 0x00000030. Does it mean I'm
> trying to wrongly access physical/virtual address 0x30 somewhere in my
> code?

More likely a NULL pointer dereference.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
