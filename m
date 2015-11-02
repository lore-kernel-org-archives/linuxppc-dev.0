Return-Path: <linuxram@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 196E81A0CC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 05:46:32 +1100 (AEDT)
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 50F27140D6A
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2015 05:46:31 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 2 Nov 2015 13:46:28 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5128338C8046
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Nov 2015 13:46:25 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA2IkPBM60293152
 for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2015 18:46:25 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA2IkNWM019703
 for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2015 13:46:24 -0500
Date: Mon, 2 Nov 2015 10:46:19 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, hbabu@us.ibm.com, nacc@us.ibm.com
Subject: Re: [PATCH] Endian swap ->count before handing over to the nx-842
 compressor
Message-ID: <20151102184619.GD22547@ram.oc3035372033.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20151030221312.GA22547@ram.oc3035372033.ibm.com>
 <1446427476.31303.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446427476.31303.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 02, 2015 at 12:24:36PM +1100, Michael Ellerman wrote:
> On Fri, 2015-10-30 at 15:13 -0700, Ram Pai wrote:
> 
> > The nx-842 compressor overshoots the output buffer corrupting memory. Verified
> > that the following patch the issue on a LE system.
> 
> This seems like a bug fix, so it should go to stable shouldn't it? If so which
> version(s) should it apply to?
> 
> And which commit introduced the breakage? Or has it always been broken?

Mike,

	Please ignore this patch. I still run into corruption even after
	this patch.  I am looking into the issue. Will have a more
	comprehensive fix.

	BTW: it has always been broken AFAICT. I find the issue even
	with lzo software compression. So may be I am doing something
	wrong in my driver, or there is more fundamental issue. Will dig
	this further.

RP

> 
> cheers

-- 
Ram Pai
