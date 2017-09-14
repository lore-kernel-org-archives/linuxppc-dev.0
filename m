Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtNtd0rVqzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 02:15:52 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8EGEpKE122993
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 12:15:50 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cysu8egvs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 12:15:50 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 14 Sep 2017 10:15:49 -0600
Date: Thu, 14 Sep 2017 09:15:40 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 02/25] powerpc: define an additional vma bit for
 protection keys.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-11-git-send-email-linuxram@us.ibm.com>
 <20170914143807.03cd9aa3@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914143807.03cd9aa3@firefly.ozlabs.ibm.com>
Message-Id: <20170914161540.GB5698@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 02:38:07PM +1000, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:44:50 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > powerpc needs an additional vma bit to support 32 keys.
> > Till the additional vma bit lands in include/linux/mm.h
> > we have to define  it  in powerpc specific header file.
> > This is  needed to get pkeys working on power.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> 
> "This" being an arch specific hack for the additional bit?


Yes. arch-specific hack.  I am trying to get the arch specific
changes merged parallelly, along with these patches. Don't know
which one will merge first. Regardless of which patch-set
lands-in first; I have organized the code such that nothing
breaks.

RP
