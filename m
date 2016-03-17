Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR0nw28vnzDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 07:49:07 +1100 (AEDT)
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 17 Mar 2016 20:49:04 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 07B622190046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 20:48:44 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2HKn2u77209346
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 20:49:02 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2HKn1lY017957
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 14:49:01 -0600
Subject: Re: [PATCH next] cxl: Allow PSL timebase to not sync
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>
References: <1457983772-4206-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1458001649.12098.59.camel@neuling.org>
 <1458177720-sup-8617@x230.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56EB183C.9030101@linux.vnet.ibm.com>
Date: Thu, 17 Mar 2016 21:49:00 +0100
MIME-Version: 1.0
In-Reply-To: <1458177720-sup-8617@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian, Miley,

OK, I'm convinced.
New version of the patch out shortly.

   Fred
