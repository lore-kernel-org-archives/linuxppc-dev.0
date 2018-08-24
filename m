Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xqHH1bb0zDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 04:16:42 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7OIED9E027415
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 14:16:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m2msadetd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 14:16:40 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 24 Aug 2018 19:16:37 +0100
Date: Fri, 24 Aug 2018 11:16:24 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Anshuman Khandual <anshuman.linux@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mike Anderson <andmike@linux.ibm.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 00/11] Secure Virtual Machine Enablement
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
 <20180824163330.GA15438@lst.de>
MIME-Version: 1.0
In-Reply-To: <20180824163330.GA15438@lst.de>
Message-Id: <20180824181624.GM5905@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2018 at 06:33:30PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 24, 2018 at 01:25:24PM -0300, Thiago Jung Bauermann wrote:
> > [ Some people didn't receive all the patches in this series, even though
> >   the linuxppc-dev list did so trying to send again. This is exactly the
> >   same series I posted yesterday. Sorry for the clutter. ]
> 
> I'm still only getting six of the patches.

We are all receving the entire series.  And I see that the mails have
also landed on the mailing lists.  Some filter on your side
is dropping the mails?

-- 
Ram Pai
