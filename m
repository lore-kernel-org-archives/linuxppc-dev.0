Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CDFDFB7466
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2012 19:09:53 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/12] powerpc: Rework runlatch code
References: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
 <1330680922-6894-4-git-send-email-benh__48089.0872575857$1330681158$gmane$org@kernel.crashing.org>
 <m2vcldamh2.fsf@igel.home> <1334105211.2984.5.camel@pasglop>
Date: Wed, 11 Apr 2012 11:09:45 +0200
In-Reply-To: <1334105211.2984.5.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Wed, 11 Apr 2012 10:46:51 +1000")
Message-ID: <m262d6ocrq.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Subject: [PATCH] powerpc: Fix typo in runlatch code

Thanks, this works for me. :-)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
