Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B12FD1A0064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 14:31:36 +1100 (AEDT)
In-Reply-To: <1416838073-16642-1-git-send-email-ldufour@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: pseries/le: Fix endiannes issue in RTAS call from xmon
Message-Id: <20141126033136.977771401AC@ozlabs.org>
Date: Wed, 26 Nov 2014 14:31:36 +1100 (AEDT)
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-24-11 at 14:07:53 UTC, Laurent Dufour wrote:
> On pseries system (LPAR) xmon failed to enter when running in LE mode, system
> is hunging. Inititating xmon will lead to such an output on the console:

OK. You say "LPAR", by which you mean "under phyp" I think. I haven't seen this
under KVM, and it looks like KVM doesn't implement "set-indicator" so that
would explain that.

I'll take this as a bug fix and CC it to stable.

cheers
