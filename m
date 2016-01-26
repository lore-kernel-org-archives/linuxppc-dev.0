Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBF7E1A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 19:16:17 +1100 (AEDT)
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 26 Jan 2016 08:16:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 268BD17D8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 08:16:19 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0Q8GAAv58917048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 08:16:10 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0Q8GAn4015472
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 01:16:10 -0700
Subject: Re: cxl: Fix struct pid leak when attaching a process through user API
To: Michael Ellerman <mpe@ellerman.id.au>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
References: <20160126031102.1CE27140317@ozlabs.org>
Cc: stable@vger.kernel.org
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56A72B49.6040104@linux.vnet.ibm.com>
Date: Tue, 26 Jan 2016 09:16:09 +0100
MIME-Version: 1.0
In-Reply-To: <20160126031102.1CE27140317@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/01/2016 04:11, Michael Ellerman a écrit :
> This no longer applies, since we merged 7b8ad495d592 ("cxl: Fix DSI misses when
> the context owning task exits").

Yes, on 4.5, it has been superseded by 7b8ad495d592.
It may still be worth considering for stable releases though.

   Fred
