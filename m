Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67F161A026F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 07:38:25 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 3 Mar 2015 13:38:23 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id CCC9D19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 13:29:28 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t23KcKJp29425918
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Mar 2015 13:38:20 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t23Kbs2C026229
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Mar 2015 13:37:55 -0700
Message-ID: <54F61B90.7090004@linux.vnet.ibm.com>
Date: Tue, 03 Mar 2015 12:37:36 -0800
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 0/3] powerpc/pseries: Fixes and cleanup of
 suspend/migration code
References: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1425363044.20929.0.camel@ellerman.id.au>
In-Reply-To: <1425363044.20929.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com, nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/02/2015 10:10 PM, Michael Ellerman wrote:
> On Fri, 2015-02-27 at 18:24 -0800, Tyrel Datwyler wrote:
>> This patchset simplifies the usage of rtas_ibm_suspend_me() by removing an
>> extraneous function parameter, fixes device tree updating on little endian
>> platforms, and adds a mechanism for informing drmgr that the kernel is cabable of
>> performing the whole migration including device tree update itself.
>>
>> Tyrel Datwyler (3):
>>   powerpc/pseries: Simplify check for suspendability during
>>     suspend/migration
>>   powerpc/pseries: Little endian fixes for post mobility device tree
>>     update
>>   powerpc/pseries: Expose post-migration in kernel device tree update
>>     to drmgr
> 
> Hi Tyrel,
> 
> Firstly let me say how much I hate this code, so thanks for working on it :)

I did it once. Might as well sacrifice my sanity a second time. :)

> 
> But I need you to split this series, into 1) fixes for 4.0 (and stable?), and
> 2) the rest.
> 
> I *think* that would be patch 2, and then patches 1 & 3, but I don't want to
> guess. So please resend.

Sure. Your split seems correct as patch 2 is fixes while 1 and 3 are
cosmetic/new feature. Seeing as patch 1 is endian fixes I'll Cc -stable
as well.

-Tyrel

> 
> cheers
> 
> 
> 
> 
