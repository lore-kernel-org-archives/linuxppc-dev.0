Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8gQ43LgDzDqdP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:58:20 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0R0tNsU028045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 19:58:18 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 287s74d01k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 19:58:17 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 27 Jan 2017 10:58:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 966692CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:58:13 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0R0w5Qe30474248
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:58:13 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0R0veRP006487
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:57:41 +1100
Subject: Re: [v2] cxl: prevent read/write to AFU config space while AFU not
 configured
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <3v8g1Z5Gdyz9t5m@ozlabs.org>
Cc: ukrishn@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, imunsie@au1.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 27 Jan 2017 11:57:16 +1100
MIME-Version: 1.0
In-Reply-To: <3v8g1Z5Gdyz9t5m@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <1914c3dc-7e4d-30de-88b0-7959e6249f39@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/01/17 11:40, Michael Ellerman wrote:
> Applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/14a3ae34bfd0bcb1cc12d55b06a858

Will fix the remaining locking issue in a follow up patch...

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
