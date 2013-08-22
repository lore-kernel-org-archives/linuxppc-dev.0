Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A1192C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 16:41:56 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 22 Aug 2013 12:01:43 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E3B4E394005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 12:11:38 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7M6hMi129622308
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 12:13:22 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7M6fkw4031153
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 12:11:47 +0530
Message-ID: <5215B288.7040609@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 12:11:12 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH V3 3/5] powerpc/cpuidle: Generic powerpc backend
 cpuidle driver.
References: <20130819042736.8609.17890.stgit@deepthi.in.ibm.com>
 <20130819042818.8609.77060.stgit@deepthi.in.ibm.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259010226D5@039-SN2MPN1-021.039d.mgd.msft.net>
 <5211F0E0.7080507@linux.vnet.ibm.com>
 <1376936241.31636.352.camel@snotra.buserror.net>
 <521447E7.5000302@linux.vnet.ibm.com>
 <1377115703.5029.14.camel@snotra.buserror.net>
 <5215A69F.4090904@linux.vnet.ibm.com> <1377151097.25016.287.camel@pasglop>
In-Reply-To: <1377151097.25016.287.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 Scott Wood <scottwood@freescale.com>,
 "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>,
 "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2013 11:28 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-08-22 at 11:20 +0530, Deepthi Dharwar wrote:
>> But if having cpuidle backend-driver separately for other powerpc arcs
>> makes sense such that each one have their own state information etc
>> then it makes sense to name the files as cpuidle-power.c,
>> cpuilde-ppc32.c and so on.
> 
> If by "power" you mean IBM POWER machines/CPUs, then make it
> cpuidle-ibm-power or cpuidle-book3s64 maybe to clarify what families it
> affects.

Sure. Thanks :)

Regards,
Deepthi


> Cheers
> Ben.
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
