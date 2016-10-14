Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swMNs6KcxzDt2l
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 20:14:21 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9E9DwIW135523
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 05:14:19 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 262maxk78e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 05:14:18 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 14 Oct 2016 14:44:15 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0F816394006A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 14:44:07 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9E9E6Xs29950192
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 14:44:06 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9E9E2gv010551
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 14:44:05 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, gkurz@linux.vnet.ibm.com
Subject: Re: [PATCH v3] cxl: Prevent adapter reset if an active context exists
In-Reply-To: <878ttrepiq.fsf@concordia.ellerman.id.au>
References: <1476356908-302-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <878ttrepiq.fsf@concordia.ellerman.id.au>
Date: Fri, 14 Oct 2016 14:43:56 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmyni97v.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mpe,

Michael Ellerman <mpe@ellerman.id.au> writes:
> This is arguably a change to the ABI, but I assume we're OK with that as
> it's arguably a bug in the existing implementation?
Yes cross checked with Fred and he is ok with this.

>
> If so do we have a Fixes: ? and/or should this go to stable?
Yes and Yes. I will resend the patch marking it for stable and updating
the 'Fixes:' tag.

Thanks,
~ Vaibhav
