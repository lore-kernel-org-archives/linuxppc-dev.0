Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 10E141007D1
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 21:43:22 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 10 Nov 2011 16:13:18 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAAAhGCi3010560
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 16:13:16 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAAAhGOj015748
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 21:43:16 +1100
Date: Thu, 10 Nov 2011 16:13:15 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Cong Wang <amwang@redhat.com>
Subject: Re: [RFC PATCH v4 02/10] fadump: Reserve the memory for firmware
 assisted	dump.
Message-ID: <20111110104315.GB5145@in.ibm.com>
References: <20111107095215.1997.14866.stgit@mars.in.ibm.com>
 <20111107095527.1997.79902.stgit@mars.in.ibm.com>
 <4EBB9FEE.9090905@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EBB9FEE.9090905@redhat.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>,
 Anton Blanchard <anton@samba.org>
Reply-To: mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2011-11-10 17:57:02 Thu, Cong Wang wrote:
> Hi, Mahesh,
> 
> Your patch seems have some style problems... checkpatch.pl complains,
> 
> total: 330 errors, 1 warnings, 355 lines checked
> 
> NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
>       scripts/cleanfile
> 
> Could use scripts/checkpatch.pl to check your patch?

I do run the checkpatch.pl before sending patches out. I am not sure how
I missed this one. Will do better job next time.

Thanks,

-- 
Mahesh J Salgaonkar
