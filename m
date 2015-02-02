Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 617D81A0C75
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 21:26:08 +1100 (AEDT)
Date: Mon, 2 Feb 2015 21:26:07 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Add trace point for tracking hash pte fault
Message-ID: <20150202212607.7585dedb@kryten>
In-Reply-To: <1422425467.11009.2.camel@ellerman.id.au>
References: <1421753750-17135-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1421809627.4900.1.camel@ellerman.id.au>
 <87d268v7xm.fsf@linux.vnet.ibm.com>
 <1422425467.11009.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> > ebizzy with -S 30 -t 1 -P gave
> > 13627 records/s -> Without patch
> > 13546 records/s -> With patch with tracepoint disabled
> 
> OK. So that's about -0.6%. Are we happy with that? I'm not sure.
> 
> Can you do a few more runs and see if that's a stable result.

Surprisingly large. Is CONFIG_JUMP_LABEL enabled? That should reduce the
tracepoint to just a nop.

Anton
