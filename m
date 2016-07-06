Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkp4p4vY2zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 14:42:02 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u664cinc146066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 00:42:00 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 240nehr8ts-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 00:41:59 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 6 Jul 2016 14:41:57 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A64422CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 14:41:54 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u664fseI5046534
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:41:54 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u664fr1k025516
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:41:54 +1000
Date: Wed, 6 Jul 2016 14:41:52 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] Add KVM_CAP_PPC_HTM to linux/kvm.h
References: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
 <d2e391d1e0e381276ee2bff8e59d872c4b3bd2b5.1467695915.git.sam.bobroff@au1.ibm.com>
 <20160705060558.GL2251@voom.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160705060558.GL2251@voom.fritz.box>
Message-Id: <20160706044152.GA5662@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 05, 2016 at 04:05:58PM +1000, David Gibson wrote:
> On Tue, Jul 05, 2016 at 03:19:23PM +1000, Sam Bobroff wrote:
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> 
> Ok, so the usual procedure for updates to linux-headers is this:
>    1. Get the change merged on the kernel side
> 
>    2. Use scripts/update-linux-headers.sh to update the whole
>       linux-headers subtree to the new kernel version
> 
>    3. Submit the patch - make sure to include the commit id of the
>       kernel you updated to in the qemu commit message

Thanks,

Do you think we're at the point with this patch set that I should start
progressing the kernel side change now?

Cheers,
Sam.
