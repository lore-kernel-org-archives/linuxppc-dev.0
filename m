Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97AAC1A0288
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 19:19:53 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 26 Nov 2014 08:19:49 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 926AE17D8043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 08:20:03 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQ8JlV957278562
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 08:19:47 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQ8Jl5a003736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 01:19:47 -0700
Message-ID: <54758D22.8040704@linux.vnet.ibm.com>
Date: Wed, 26 Nov 2014 09:19:46 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: pseries/le: Fix endiannes issue in RTAS call from xmon
References: <20141126033136.977771401AC@ozlabs.org>
In-Reply-To: <20141126033136.977771401AC@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/11/2014 04:31, Michael Ellerman wrote:
> OK. You say "LPAR", by which you mean "under phyp" I think. I haven't seen this
> under KVM, and it looks like KVM doesn't implement "set-indicator" so that
> would explain that.

Yes LPAR implies phyp, and KVM don't implement "set-indicator" so this
doesn't happen in that case.

> I'll take this as a bug fix and CC it to stable.

That's a good point.

Thanks,
Laurent.
