Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wncVV6tgZzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 16:41:38 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5E6eivs027440
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 02:41:36 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b302rg11b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 02:41:36 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 14 Jun 2017 16:41:33 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5E6fLNs4784420
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 16:41:30 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5E6evEb005129
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 16:40:57 +1000
Subject: Re: [PATCH] recordmcount.pl: Add ppc64le to list of supported
 architectures
To: Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>
References: <1497336599-17894-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <CAKTCnz=xeDFbyPwsdewq-5NK9cgQpBVCfCX_iL5f8u2-y7HwDw@mail.gmail.com>
 <87a85b41ce.fsf@concordia.ellerman.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Wed, 14 Jun 2017 12:10:39 +0530
MIME-Version: 1.0
In-Reply-To: <87a85b41ce.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3a3a708b-a50a-c865-4e83-1d78b612ce27@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 14 June 2017 10:23 AM, Michael Ellerman wrote:
>> I don't get this, the arch should always be powerpc.
> Right. Something else is fubar for that to happen, we should fix
> whatever it is.

Agree, ARCH over-ruling by reading the underlying architecture will
not work, as the expectation is to have ARCH=powerpc for all of the 
powerpc platform. Sorry for the noise, kindly ignore this patch.

-- 
cheers,
Kamalesh.
