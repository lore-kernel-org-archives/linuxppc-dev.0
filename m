Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJXrz3vL0zDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 09:29:39 +1000 (AEST)
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4UNT79s027026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 19:29:37 -0400
Message-Id: <201605302329.u4UNT79s027026@mx0a-001b2d01.pphosted.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 238k017cff-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 19:29:36 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 31 May 2016 09:29:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 99AB12BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 09:29:31 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4UNTNIA7864672
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 09:29:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4UNSwvA005844
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 09:28:59 +1000
Subject: Re: [PATCH] cxl: Abstract the differences between the PSL and XSL
To: Michael Ellerman <mpe@ellerman.id.au>,
 John W Walthour <jwalthour@us.ibm.com>, fbarrat@linux.vnet.ibm.com
References: <57484202.1050603@linux.vnet.ibm.com>
 <1464025158-23849-1-git-send-email-imunsie@au.ibm.com>
 <20160527130754.71F7DBE03E@b03ledav005.gho.boulder.ibm.com>
 <1464649282.16938.0.camel@ellerman.id.au>
Cc: huyn@mellanox.com, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 imunsie@au1.ibm.com, frederic.barrat@fr.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 31 May 2016 09:28:33 +1000
MIME-Version: 1.0
In-Reply-To: <1464649282.16938.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/05/16 09:01, Michael Ellerman wrote:
>> Those come from
>> XSL_databook_09_June_2014.pdf
>
> Where do I find that?

My understanding is that it's IBM Confidential and isn't available to 
the general community, unfortunately.


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
