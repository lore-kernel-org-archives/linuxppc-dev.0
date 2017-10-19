Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHw6p5WcszDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 03:56:02 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JGsAiu085152
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 12:56:00 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpws21f6v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 12:55:59 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 19 Oct 2017 12:55:58 -0400
Date: Thu, 19 Oct 2017 09:55:51 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 21/25] powerpc: introduce get_pte_pkey() helper
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-30-git-send-email-linuxram@us.ibm.com>
 <20171019102944.40c9c232@MiWiFi-R3-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019102944.40c9c232@MiWiFi-R3-srv>
Message-Id: <20171019165551.GV5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 10:29:44AM +1100, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:45:09 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > get_pte_pkey() helper returns the pkey associated with
> > a address corresponding to a given mm_struct.
> >
> 
> This is really get_mm_addr_key() -- no?

ok. will be so.

RP
