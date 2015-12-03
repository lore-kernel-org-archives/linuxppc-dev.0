Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 678491A078B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 17:06:20 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 2 Dec 2015 23:06:18 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 77CC71FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 22:54:27 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB366GVQ18612364
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 23:06:16 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB366FvJ004364
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 23:06:16 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/4] powerpc/powernv: remove FW_FEATURE_OPAL and just use
 FW_FEATURE_OPALv3
In-Reply-To: <1448942184.9027.7.camel@ellerman.id.au>
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1448599526-31073-4-git-send-email-stewart@linux.vnet.ibm.com>
 <1448942184.9027.7.camel@ellerman.id.au>
Date: Thu, 03 Dec 2015 17:06:03 +1100
Message-ID: <874mg0gj78.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Fri, 2015-11-27 at 15:45 +1100, Stewart Smith wrote:
>
>> Long ago, only in the lab, there was OPALv1 and OPALv2. Now there is
>> just OPALv3, with nobody ever expecting anything on pre-OPALv3 to
>> be cared about or supported by mainline kernels.
>> 
>> So, let's remove FW_FEATURE_OPAL and instead use FW_FEATURE_OPALv3
>> exclusively.
>
> It would be less churn if we did the reverse, ie. removed v3 and just used
> FW_FEATURE_OPAL. It would also read better as v3 is the one and only version we
> care about, so having it called out everywhere is superfluous.
>
> Or is there a good reason I missed?

excessive caution?

I'll send a V2 patchset doing the reverse, leaving FW_FEATURE_OPAL.
