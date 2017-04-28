Return-Path: <srs0=h8hu=4e=aculab.com=david.laight@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDqZG5GGWzDqK7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 20:20:06 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wDqZG2dPvz8vDh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 20:20:06 +1000 (AEST)
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wDqZF5T20z9s8H
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 20:20:05 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH] powerpc/xive: Fix/improve verbose debug output
Date: Fri, 28 Apr 2017 09:58:02 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFE1083@AcuExch.aculab.com>
References: <1493301446.25766.276.camel@kernel.crashing.org>
 <87zif1p6vw.fsf@concordia.ellerman.id.au>
 <1493356805.25766.296.camel@kernel.crashing.org>
 <874lx99h25.fsf@concordia.ellerman.id.au>
In-Reply-To: <874lx99h25.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman
> Sent: 28 April 2017 07:34
...
> Not sure what you mean. You can enable pr_debug()s individually, by
> function, by module, by file, or for the whole kernel.

It is sort of a shame that you can't turn pr_info() off in the same way.

	David
