Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTLDj3DSZzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 15:03:01 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1N3wXuK112549
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 23:02:59 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28sn436kv8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 23:02:59 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 23 Feb 2017 14:02:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 17F8A2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 15:02:55 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1N42kAv41091194
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 15:02:54 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1N42MMg020452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 15:02:22 +1100
Subject: Re: [RFC] Remove memory from nodes for memtrace.
To: Nicholas Piggin <npiggin@gmail.com>, Rashmica Gupta <rashmica.g@gmail.com>
References: <20170222213910.5628-1-rashmica.g@gmail.com>
 <20170223135635.5321dcc5@roar.ozlabs.ibm.com>
Cc: dllehr@us.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 23 Feb 2017 15:01:58 +1100
MIME-Version: 1.0
In-Reply-To: <20170223135635.5321dcc5@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <1be421cf-71f2-6e89-90be-fd701b3865da@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/02/17 14:56, Nicholas Piggin wrote:
>> Written by Douglas Lehr <dllehr@us.ibm.com>.
>
> You could mention original author in the changelog. I thought Anton
> wrote some of it too?

You'll want to include the Signed-off-by of all authors involved.


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
