Return-Path: <mike.marciniszyn@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qqnQy1lkHzDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 02:29:45 +1000 (AEST)
From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Doug
 Ledford" <dledford@redhat.com>, "Hefty, Sean" <sean.hefty@intel.com>, "Hal
 Rosenstock" <hal.rosenstock@gmail.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V2] powerpc/infiniband: Use cache inhibitted and guarded
 mapping on powerpc
Date: Wed, 20 Apr 2016 16:29:42 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC25ACE29D@fmsmsx120.amr.corp.intel.com>
References: <1461139097-10213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1461139097-10213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Aneesh Kumar K.V [mailto:aneesh.kumar@linux.vnet.ibm.com]
> Sent: Wednesday, April 20, 2016 3:58 AM
> Subject: [PATCH V2] powerpc/infiniband: Use cache inhibitted and guarded
> mapping on powerpc
>=20

Doug, can you fix up the summary to git the spelling error and powerpc/infi=
niband:  -> IB/qib:

Thanks for the patch!

Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
