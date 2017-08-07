Return-Path: <srs0=zgr7=7j=nefkom.net=whitebox@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQvDx3lJQzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:40:17 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xQvDx3Cmhz8vJY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:40:17 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xQvDx07WKz9sR9
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2017 20:40:15 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,  linuxppc-dev@ozlabs.org
Subject: Re: 4.13-rc3: Unrecoverable exception 4100
References: <87vam3lhtn.fsf__12885.8019285419$1501844971$gmane$org@linux-m68k.org>
 <87fud7ktqf.fsf__17563.3519575515$1501875675$gmane$org@linux-m68k.org>
 <877eyjkt0u.fsf@linux-m68k.org>
 <20170805233917.72e49d2f@roar.ozlabs.ibm.com>
 <877eyfpupf.fsf@concordia.ellerman.id.au>
Date: Mon, 07 Aug 2017 12:40:09 +0200
In-Reply-To: <877eyfpupf.fsf@concordia.ellerman.id.au> (Michael Ellerman's
 message of "Mon, 07 Aug 2017 19:56:28 +1000")
Message-ID: <mvma83boe46.fsf@linux-m68k.org>
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

On Aug 07 2017, Michael Ellerman <mpe@ellerman.id.au> wrote:

> Ah of course. Not sure why I haven't seen it in any of my testing :/

It took me a whole gcc bootstrap to trigger it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
