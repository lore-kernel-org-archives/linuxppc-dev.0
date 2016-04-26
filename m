Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvKwH0gZ7zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 21:03:59 +1000 (AEST)
Message-ID: <1461668632.31920.1.camel@ellerman.id.au>
Subject: Re: [PATCH V2] powerpc/infiniband: Use cache inhibitted and guarded
 mapping on powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Doug
 Ledford <dledford@redhat.com>, "Hefty, Sean" <sean.hefty@intel.com>, Hal
 Rosenstock <hal.rosenstock@gmail.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>
Date: Tue, 26 Apr 2016 21:03:52 +1000
In-Reply-To: <32E1700B9017364D9B60AED9960492BC25ACE29D@fmsmsx120.amr.corp.intel.com>
References: <1461139097-10213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <32E1700B9017364D9B60AED9960492BC25ACE29D@fmsmsx120.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-20 at 16:29 +0000, Marciniszyn, Mike wrote:
> > From: Aneesh Kumar K.V [mailto:aneesh.kumar@linux.vnet.ibm.com]
> > Sent: Wednesday, April 20, 2016 3:58 AM
> > Subject: [PATCH V2] powerpc/infiniband: Use cache inhibitted and guarded
> > mapping on powerpc
> > 
> 
> Doug, can you fix up the summary to git the spelling error and powerpc/infiniband:  -> IB/qib:

We'll need to take this via the powerpc tree, we have a 68 patch series that
depends on it. I'm happy to update the subject.

cheers
