Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtQHt17RCzDrN5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 03:19:21 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8EHJ26v126690
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 13:19:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cyuy0yafj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 13:19:18 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 14 Sep 2017 13:19:18 -0400
Date: Thu, 14 Sep 2017 10:19:11 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 7/7] powerpc: capture the PTE format changes in the dump
 pte report
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-8-git-send-email-linuxram@us.ibm.com>
 <20170914132227.204ae9ac@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914132227.204ae9ac@firefly.ozlabs.ibm.com>
Message-Id: <20170914171911.GD5698@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 01:22:27PM +1000, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:44:47 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > The H_PAGE_F_SECOND,H_PAGE_F_GIX are not in the 64K main-PTE.
> > capture these changes in the dump pte report.
> > 
> > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> 
> So we lose slot and secondary information for 64K PTE's with
> this change?

yes. It was anyway not there for 4k-backed-64k ptes. Now it wont
be there for any 64k ptes.

RP
