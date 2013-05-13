Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 107022C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 19:23:02 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 13 May 2013 14:47:24 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 40F351258023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 14:54:47 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4D9Mpen53936152
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 14:52:51 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4D9Msqj014624
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 19:22:56 +1000
Message-ID: <1368436970.2618.48.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH v3 0/5] powerpc: Support context tracking for Power
 pSeries
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 13 May 2013 17:22:50 +0800
In-Reply-To: <1368435563.19924.28.camel@pasglop>
References: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1368424306.19924.20.camel@pasglop>
 <1368432193.2618.30.camel@ThinkPad-T5421>
 <1368435563.19924.28.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fweisbec@gmail.com, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, paulus@samba.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-13 at 18:59 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-13 at 16:03 +0800, Li Zhong wrote:
> > 
> > To my understanding, it is used to enable RCU user extended quiescent
> > state, so RCU on that cpu doesn't need scheduler ticks. And together
> > with some other code(already in 3.10), we are able to remove the ticks
> > in some cases (e.g. only 1 task running on the cpu, with some other
> > limitations).
> 
> Ok, sounds interesting. Once you fix the little cosmetic issue, I don't
> see any reason not to merge them as it's basically wiring up an existing
> feature (in that regard the patches are pretty straightforward) and I
> assume the overhead is only there when you enable it.

Thanks for your support, Ben.

Yes, there should be no overhead if not enabled. 

Thanks, Zhong

> 
> Cheers,
> Ben.
> 
> 
