Return-Path: <srs0=b8ek=3p=linux.vnet.ibm.com=sachinp@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzmzt38MdzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 14:38:34 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzmzt2R45z8syC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 14:38:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzmzs5Pgxz9s7m
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 14:38:33 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v374Y139125155
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 00:38:31 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29p3dc1csg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Apr 2017 00:38:30 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 10:08:27 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v374cJMG18284784
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 10:08:19 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v374cO4Z022316
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 10:08:24 +0530
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: WARN @lib/refcount.c:128 during hot unplug of I/O adapter.
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <a7a782f2-3783-fd96-eda9-1c7634b2a2e5@linux.vnet.ibm.com>
Date: Fri, 7 Apr 2017 10:08:23 +0530
Cc: linuxppc-dev@ozlabs.org,
 "nfont >> Nathan Fontenot" <nfont@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <E5B3D5CE-EB6A-4470-B7E9-4F6F7B029809@linux.vnet.ibm.com>
 <a7a782f2-3783-fd96-eda9-1c7634b2a2e5@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Message-Id: <D5BDC786-03CF-423C-AFD6-2F8679F465C8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On 07-Apr-2017, at 2:14 AM, Tyrel Datwyler <tyreld@linux.vnet.ibm.com> =
wrote:
>=20
> On 04/06/2017 03:27 AM, Sachin Sant wrote:
>> On a POWER8 LPAR running 4.11.0-rc5, a hot unplug operation on
>> any I/O adapter results in the following warning
>=20
> I remember you mentioning this when the issue was brought up for CPUs. =
I
> assume the case is the same here where the issue is only seen with
> adapters that were hot-added after boot (ie. hot-remove of adapter
> present at boot doesn't trip the warning)?
>=20

Correct, can be recreated only with adapters that were hot-added after =
boot.

> -Tyrel
>=20
>>=20
>> Thanks
>> -Sachin
>>=20
>>=20
>=20
