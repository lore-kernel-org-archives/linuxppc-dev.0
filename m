Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60334V0zDvyH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:33:39 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tN6025xCFz9s3s
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Nov 2016 11:33:38 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAM0XYZ6089734
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2016 19:33:36 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26v58k0mru-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2016 19:33:36 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 22 Nov 2016 10:33:33 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1D3402CE8056
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Nov 2016 11:33:30 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAM0XT9u53870808
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Nov 2016 11:33:29 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAM0XTrJ000625
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Nov 2016 11:33:29 +1100
Subject: Re: [PATCH 2/3] powerpc/boot: All uses of if_changed should depend on
 FORCE
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1479723275-11736-1-git-send-email-mpe@ellerman.id.au>
 <1479723275-11736-2-git-send-email-mpe@ellerman.id.au>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 22 Nov 2016 11:33:28 +1100
MIME-Version: 1.0
In-Reply-To: <1479723275-11736-2-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f14b3cc5-5d3c-5c2a-f4a5-70e1ad08892d@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21/11/16 21:14, Michael Ellerman wrote:
> From: Michael Ellerman <michael@ka3.ozlabs.ibm.com>

Not the most publicly resolvable of domains :)

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
