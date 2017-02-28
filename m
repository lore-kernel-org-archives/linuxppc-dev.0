Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXvgP4d05zDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 10:20:01 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1SNJDJ6026874
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:19:59 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wjr5r3j8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:19:59 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 1 Mar 2017 09:19:56 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 939082CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 10:19:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1SNJjdV45154408
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 10:19:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1SNJKV4002793
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 10:19:20 +1100
Subject: Re: [PATCH v3] powerpc/powernv: add hdat attribute to sysfs
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Oliver O'Halloran" <oohall@gmail.com>
References: <20170224062054.31408-1-matthew.brown.dev@gmail.com>
 <87lgsrrjfb.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Brown <matthew.brown.dev@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 1 Mar 2017 10:18:54 +1100
MIME-Version: 1.0
In-Reply-To: <87lgsrrjfb.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0c2f06b3-ac9f-0021-df70-bdfa850055d2@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/02/17 21:56, Michael Ellerman wrote:
>> +/* HDAT attribute for sysfs */
>> +static struct bin_attribute hdat_attr = {
>> +	.attr = {.name = "hdat", .mode = 0444},
>                                          ^^^^
> ajd and oohal report to my office.

...ACK... :/

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
