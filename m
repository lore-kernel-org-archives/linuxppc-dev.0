Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjdqD18GVzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:26:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rjdqC3yS6z9sBm
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:26:15 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u647O1ks060038
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jul 2016 03:26:13 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23x77wnhdc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Jul 2016 03:26:12 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 4 Jul 2016 17:26:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0BB0B2CE8056
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:26:08 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u647Q7tR10551584
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jul 2016 17:26:07 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u647Q7Zr027865
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Jul 2016 17:26:07 +1000
Subject: Re: [PATCH 1/6] powerpc/kvm: Clarify __user annotations
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
References: <1467616182-30886-1-git-send-email-dja@axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 4 Jul 2016 17:26:07 +1000
MIME-Version: 1.0
In-Reply-To: <1467616182-30886-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <66157a72-8017-bb61-e0bf-38f42f0831eb@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/16 17:09, Daniel Axtens wrote:
> kvmppc_h_put_tce_indirect labels a u64 pointer as __user. It also
> labelled the u64 where get_user puts the result as __user. This isn't
> a pointer and so doesn't need to be labelled __user.
>
> Split the u64 value definition onto a new line to make it clear that
> it doesn't get the annotation.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
