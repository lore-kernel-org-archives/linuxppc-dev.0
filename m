Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CFA21A0FBF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 21:47:39 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 21:47:38 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 690D83578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 21:47:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5BBlQ4R54526118
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 21:47:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5BBl2f7007392
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 21:47:03 +1000
Message-ID: <55797524.2010301@linux.vnet.ibm.com>
Date: Thu, 11 Jun 2015 17:16:44 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
CC: mpe@ellerman.id.au, joel@jms.id.au, vaibhav@linux.vnet.ibm.com
Subject: Re: [PATCH v8] powerpc/powernv: Poweroff (EPOW, DPO) events support
 for PowerNV platform
References: <1433965909-9910-1-git-send-email-vipin@linux.vnet.ibm.com>
 <m3fv5zdvho.fsf@oc8180480414.ibm.com>
In-Reply-To: <m3fv5zdvho.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 06/11/2015 04:25 AM, Stewart Smith wrote:
> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>> This patch adds support for FSP (Flexible Service Processor)
>> EPOW (Early Power Off Warning) and DPO (Delayed Power Off) events for
> Not restricted to FSP systems, it's a generic OPAL API that any platform
> could implement.

Re-phrased commit log message and re-posted patch.
