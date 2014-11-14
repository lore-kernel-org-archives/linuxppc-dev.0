Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C6131A019F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 13:00:49 +1100 (AEDT)
Message-ID: <5465624F.6010605@ozlabs.org>
Date: Fri, 14 Nov 2014 10:00:47 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: minyard@acm.org, linuxppc-dev@lists.ozlabs.org,
 openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH v2] drivers/char/ipmi: Add powernv IPMI driver
References: <1415778065.431549.108606915276.1.gpush@pablo>
 <54655DFE.6080503@acm.org>
In-Reply-To: <54655DFE.6080503@acm.org>
Content-Type: text/plain; charset=windows-1252
Cc: Michael Ellerman <michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Corey,

> This looks good.  Can this go into the IPMI tree now, or does it need
> work done in the PowerPC tree first?

The 1/2 patch is already in the powerpc tree - but to ensure that we hit
Linus' tree in the right order, Michael has suggested that you merge his
topic branch (which only has that one change):


https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=topic/opal-ipmi

- then apply the patch. This way, whichever tree Linus pulls first will
have the changes in the correct order.

Cheers,


Jeremy
