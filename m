Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B9471A0932
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 12:24:37 +1100 (AEDT)
Message-ID: <1446427476.31303.2.camel@ellerman.id.au>
Subject: Re: [PATCH] Endian swap ->count before handing over to the nx-842
 compressor
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@ozlabs.org
Cc: hbabu@us.ibm.com, nacc@us.ibm.com
Date: Mon, 02 Nov 2015 12:24:36 +1100
In-Reply-To: <20151030221312.GA22547@ram.oc3035372033.ibm.com>
References: <20151030221312.GA22547@ram.oc3035372033.ibm.com>
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

On Fri, 2015-10-30 at 15:13 -0700, Ram Pai wrote:

> The nx-842 compressor overshoots the output buffer corrupting memory. Verified
> that the following patch the issue on a LE system.

This seems like a bug fix, so it should go to stable shouldn't it? If so which
version(s) should it apply to?

And which commit introduced the breakage? Or has it always been broken?

cheers
