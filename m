Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8F031B7069
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2012 09:05:31 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/12] powerpc: Rework runlatch code
References: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
 <1330680922-6894-4-git-send-email-benh__48089.0872575857$1330681158$gmane$org@kernel.crashing.org>
 <m2vcldamh2.fsf@igel.home> <1333663961.3040.34.camel@pasglop>
Date: Fri, 06 Apr 2012 01:05:22 +0200
In-Reply-To: <1333663961.3040.34.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Fri, 06 Apr 2012 08:12:41 +1000")
Message-ID: <m2mx6paifh.fsf@igel.home>
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

> Have you verified that you can "fix" it with reverting just the above
> patch ?

Yes.

(Currently running 3.4-rc1 with fe1952f reverted and irq_set_irq_type
removed from mpic_host_map.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
