Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7ACFB1A017D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 19:56:05 +1100 (AEDT)
In-Reply-To: <874mg0gj78.fsf@linux.vnet.ibm.com>
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1448599526-31073-4-git-send-email-stewart@linux.vnet.ibm.com>
 <1448942184.9027.7.camel@ellerman.id.au> <874mg0gj78.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 3/4] powerpc/powernv: remove FW_FEATURE_OPAL and just use
 FW_FEATURE_OPALv3
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 03 Dec 2015 19:25:59 +1030
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Message-ID: <42CAC831-3C07-433D-9921-A7E302A26BE2@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 3 December 2015 4:36:03 pm ACDT, Stewart Smith <stewart@linux.vnet.ibm.com> wrote:
>Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> On Fri, 2015-11-27 at 15:45 +1100, Stewart Smith wrote:
>>
>>> Long ago, only in the lab, there was OPALv1 and OPALv2. Now there is
>>> just OPALv3, with nobody ever expecting anything on pre-OPALv3 to
>>> be cared about or supported by mainline kernels.
>>> 
>>> So, let's remove FW_FEATURE_OPAL and instead use FW_FEATURE_OPALv3
>>> exclusively.
>>
>> It would be less churn if we did the reverse, ie. removed v3 and just
>used
>> FW_FEATURE_OPAL. It would also read better as v3 is the one and only
>version we
>> care about, so having it called out everywhere is superfluous.
>>
>> Or is there a good reason I missed?
>
>excessive caution?

Yeah fair enough.

>I'll send a V2 patchset doing the reverse, leaving FW_FEATURE_OPAL.

Thanks.

cheers

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
