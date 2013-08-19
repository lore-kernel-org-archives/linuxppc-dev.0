Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A61C2C0165
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 14:44:15 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 10:08:20 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7704E1258043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 10:13:51 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7J4jXgO35979476
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 10:15:34 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7J4i5TA008212
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 10:14:06 +0530
Message-ID: <5211A273.1080903@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 10:13:31 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V2 5/6] cpuidle/powerpc: Backend-powerpc idle driver for
 powernv and pseries.
References: <20130731025840.19448.24468.stgit@deepthi>
 <20130731025934.19448.16658.stgit@deepthi>
 <1375830520.5600.23.camel@snotra.buserror.net>
 <1375831851.12557.74.camel@pasglop>
 <1375832471.5600.41.camel@snotra.buserror.net>
In-Reply-To: <1375832471.5600.41.camel@snotra.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
 dongsheng.wang@freescale.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
 srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/2013 05:11 AM, Scott Wood wrote:
> On Wed, 2013-08-07 at 09:30 +1000, Benjamin Herrenschmidt wrote:
>> On Tue, 2013-08-06 at 18:08 -0500, Scott Wood wrote:
>>> Here's another example.  get_lppaca() will only build on book3s -- and
>>> yet we get requests for e500 code to use this file.
>>
>> Indeed, Besides there is already accessors afaik for lppaca that compile
>> to nothing on E (and if not they would be trivial to add).
> 
> I don't see such an accessor, but if there were, what would happen when
> the caller goes on to dereference that nothing?
> 
> There is an accessor for shared_proc specifically (in the spinlock code)
> -- not that it would be much help on booke to just compile away that
> check and always select one of the pseries state tables over the other.
> 
> -Scott

Thanks a lot Scott and Ben for the review.
I have addressed the issues in V3 of this patch series which I have just
posted out.

Regards,
Deepthi


> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
