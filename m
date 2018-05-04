Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d5FH0ScrzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 07:46:42 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w44LkSwf134380
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 May 2018 17:46:40 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hrtagmw89-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 17:46:37 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 4 May 2018 22:45:17 +0100
Date: Fri, 4 May 2018 14:45:07 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, fweimer@redhat.com,
 Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org,
 Ulrich.Weigand@de.ibm.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
 <20180504232647.3412f563@naga.suse.cz>
 <edd3d544-9fa8-5a79-4325-818ee5d7dfb0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <edd3d544-9fa8-5a79-4325-818ee5d7dfb0@intel.com>
Message-Id: <20180504214507.GA5871@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 04, 2018 at 02:31:10PM -0700, Dave Hansen wrote:
> On 05/04/2018 02:26 PM, Michal Suchánek wrote:
> > If it is not ok to change permissions of pkey 0 is it ok to free it?
> 
> It's pretty much never OK to free it on x86 or ppc.  But, we're not
> going to put code in to keep userspace from shooting itself in the foot,
> at least on x86.

and on powerpc aswell.


-- 
Ram Pai
