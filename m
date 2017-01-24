Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7PPb311BzDqDN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 10:23:31 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0ONIioV138543
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 18:23:28 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 286ahtwydg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 18:23:28 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 25 Jan 2017 09:23:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9838F2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 10:23:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0ONNGSu5636312
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 10:23:24 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0ONMpo0011062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 10:22:52 +1100
Subject: Re: [PATCH] cxl: drop unused header asm/pnv-pci.h
To: Michael Ellerman <mpe@ellerman.id.au>, Greg Kurz <groug@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
References: <148482301037.30441.14177888563610790803.stgit@bahia>
 <87k29kaih9.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 25 Jan 2017 10:22:30 +1100
MIME-Version: 1.0
In-Reply-To: <87k29kaih9.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c19db824-530f-6770-d291-8f101f860056@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/01/17 20:57, Michael Ellerman wrote:
> Greg Kurz <groug@kaod.org> writes:
>
>> The kernel API does not use anything from this header file.
>
> That's actually hard to prove in general, because pnv-pci.h includes
> linux/pci.h, linux/pci_hotplug.h, linux/irq.h, misc/cxl-base.h and
> asm/opal-api.h. At least four of which aren't included directly by
> api.c.
>
> But I'll take you word for it :)

I did compile test it before giving my Reviewed-by.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
