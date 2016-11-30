Return-Path: <whitebox@nefkom.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTSnf45WnzDvxC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 04:58:14 +1100 (AEDT)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tTSnd6pL1z9t0J
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Dec 2016 04:58:13 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "linuxppc-dev\@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v2] adb: properly mark continued kernel messages
References: <87r35ynzoe.fsf@linux-m68k.org>
 <1480200189.11342.4.camel@au1.ibm.com>
 <87oa0zpcvg.fsf_-_@linux-m68k.org>
 <063D6719AE5E284EB5DD2968C1650D6DB02303EA@AcuExch.aculab.com>
Date: Wed, 30 Nov 2016 18:58:07 +0100
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB02303EA@AcuExch.aculab.com>
 (David Laight's message of "Wed, 30 Nov 2016 14:50:41 +0000")
Message-ID: <8760n4df4g.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Nov 30 2016, David Laight <David.Laight@ACULAB.COM> wrote:

> Doesn't pr_cont() have its own major problem - garbled messages if
> there are concurrent writers?
> So it is best avoided if at all possible.

You are free to submit a followup patch the rework the messaging.  My
patch is a strict improvement.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
