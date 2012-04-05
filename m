Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1FD47B7047
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2012 22:35:11 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map;
 use irq_alloc_desc() instead
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <1333340517.30734.42.camel@pasglop>
 <m2r4w6jugo.fsf@linux-m68k.org>
 <1333401070.30734.55.camel__46349.1482347765$1333401169$gmane$org@pasglop>
Date: Thu, 05 Apr 2012 14:35:14 +0200
In-Reply-To: <1333401070.30734.55.camel__46349.1482347765$1333401169$gmane$org@pasglop>
 (Benjamin Herrenschmidt's message of "Tue, 03 Apr 2012 07:11:10
 +1000")
Message-ID: <m2obr61hml.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Hrm, odd.. I'll dbl check today that I didn't b0rk something in my test
> (like loading the wrong kernel :-) I'll also try with your config.

Do you have anything that triggers loading the sound drivers?  That's
exactly the point where the irq problems start.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
