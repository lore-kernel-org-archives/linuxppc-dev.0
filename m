Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F7111A2A85
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 19:08:35 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 18:08:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 27AF73578047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 19:08:31 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2K88MRG41353240
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 19:08:30 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2K87vHD021951
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 19:07:57 +1100
Message-ID: <550BD543.8080605@linux.vnet.ibm.com>
Date: Fri, 20 Mar 2015 13:37:31 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/powernv: Add OPAL interfaces for accessing
 and modifying system LED states
References: <20150308110558.3759.72635.stgit@localhost.localdomain>
 <20150308111408.3759.70606.stgit@localhost.localdomain>
 <1426832625.2581.3.camel@ellerman.id.au>
In-Reply-To: <1426832625.2581.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: cooloney@gmail.com, rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/20/2015 11:53 AM, Michael Ellerman wrote:
> On Sun, 2015-03-08 at 16:44 +0530, Vasant Hegde wrote:
>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>
>> This patch registers the following two new OPAL interfaces calls
>> for the platform LED subsystem. With the help of these new OPAL calls,
>> the kernel will be able to get or set the state of various individual
>> LEDs on the system at any given location code which is passed through
>> the LED specific device tree nodes.
>>
>> 	(1) OPAL_LEDS_GET_INDICATOR     opal_leds_get_ind
>> 	(2) OPAL_LEDS_SET_INDICATOR     opal_leds_set_ind
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/opal.h                |   19 +++++++++++++------
> 
> We've split opal.h in next.
> 
> Can you please rebase on top of it:
> 
> https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next

Sure.. will rebase and send v2 soon.

-Vasant
