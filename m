Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BVBD0rZ4zF0wq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 04:10:59 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5LI9YEU018119
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 14:10:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jrdyrgfhk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 14:10:56 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 21 Jun 2018 19:10:55 +0100
Date: Thu, 21 Jun 2018 11:10:45 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Florian Weimer <fweimer@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, Ulrich.Weigand@de.ibm.com,
 luto@kernel.org, msuchanek@suse.de
Subject: Re: [PATCH v2 0/6] powerpc/pkeys: fixes to pkeys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <8812c879-5761-ef62-dd15-3ceef46d9653@redhat.com>
 <874lhzx84e.fsf@concordia.ellerman.id.au>
 <34669c66-ce2f-e8a0-1d18-43086bad3faa@redhat.com>
 <878t78fn6o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <878t78fn6o.fsf@concordia.ellerman.id.au>
Message-Id: <20180621181045.GL5294@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 21, 2018 at 08:28:47PM +1000, Michael Ellerman wrote:
> Florian Weimer <fweimer@redhat.com> writes:
> 
> > On 06/19/2018 02:40 PM, Michael Ellerman wrote:
> >>> I tested the whole series with the new selftests, with the printamr.c
> >>> program I posted earlier, and the glibc test for pkey_alloc &c.  The
> >>> latter required some test fixes, but now passes as well.  As far as I
> >>> can tell, everything looks good now.
> >>>
> >>> Tested-By: Florian Weimer<fweimer@redhat.com>
> >> Thanks. I'll add that to each patch I guess, if you're happy with that?
> >
> > Sure, but I only tested the whole series as a whole.
> 
> Yeah OK. We don't have a good way to express that, other than using a
> merge which I'd prefer to avoid.
> 
> So I've tagged them all with your Tested-by. If any of them turn out to
> have bugs you can blame me :)

I just tested the patches incrementally using the pkey selftests.

So I feel confident these patches are not bugs. I will take the blame
if the blame lands on Mpe  :)

RP
