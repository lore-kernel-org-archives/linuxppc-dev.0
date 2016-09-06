Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSwwJ02pLzDrpd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 16:01:51 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u865vueT022000
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 02:01:49 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 259mjb7fpu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 02:01:48 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 6 Sep 2016 16:01:45 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 084BF3578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 16:01:40 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8661dKt56885396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 16:01:39 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8661dGD026221
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 16:01:39 +1000
Subject: Re: [PATCH v2 1/5] powerpc/cell: drop unused iic_get_irq_host()
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 6 Sep 2016 16:01:38 +1000
MIME-Version: 1.0
In-Reply-To: <1473139963-7496-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f2ec09b5-6dc6-a5ce-4177-8fd3879e5513@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/09/16 15:32, Daniel Axtens wrote:
> Sparse checking revealed that it is no longer used.
> There is an EXPORT_SYMBOL_GPL, but there's no header that
> provides a prototype, so nothing should be using it anyway.
>
> Remove it.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
