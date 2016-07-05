Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBwB0hNCzDrYp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:17:30 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBw92jbBz9sRZ
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:17:29 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u655HORJ007629
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Jul 2016 00:17:25 -0500
Message-ID: <1467695844.13965.35.camel@kernel.crashing.org>
Subject: Re: [PATCH 36/41] powerpc: Re-order setup_panic()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Tue, 05 Jul 2016 15:17:24 +1000
In-Reply-To: <1467695057-12431-37-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
 <1467695057-12431-37-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-07-05 at 15:04 +1000, Benjamin Herrenschmidt wrote:
> Do it right after probe_machine() since it's about testing ppc_md,
> and put the test in the common code.

Ignore the second copy of that patch,  they are identical, my SSH
tunnel broke down half way through sending the series.

Cheers,
Ben.
