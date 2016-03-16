Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ8hl59k9zDqGd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 22:41:43 +1100 (AEDT)
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 16 Mar 2016 11:41:39 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C7ABC1B085E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 11:33:08 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2GBWdWi65339576
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 11:32:39 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2GBWdSk005805
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 07:32:39 -0400
Subject: Re: [PATCH next] cxl: Allow PSL timebase to not sync
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <1457983772-4206-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1458001649.12098.59.camel@neuling.org>
 <1458014186.8059.5.camel@ellerman.id.au>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56E94456.8070605@linux.vnet.ibm.com>
Date: Wed, 16 Mar 2016 12:32:38 +0100
MIME-Version: 1.0
In-Reply-To: <1458014186.8059.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 15/03/2016 04:56, Michael Ellerman a écrit :
> And it just sounds like a big hack around broken hardware, which we'll have to
> carry for the foreseeable future.

I discussed with Mikey about what would be acceptable here. There's 
basically no good solution. No matter how we workaround the issue, we'll 
have to pay a price in the future.
Removing the psl timebase sync code is not desirable either as we cannot 
be 100% sure it's not being used by someone (on the cards where it works).
So our only option at this point is to just keep debugging the 
problematic setups to come up with the real fix. In the meantime, this 
patch can be dropped.


   Fred
