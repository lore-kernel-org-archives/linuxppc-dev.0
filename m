Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AFCA7DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 15:38:42 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBR4cbUw029561
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Dec 2007 23:38:37 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBR4cbbr130902
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Dec 2007 21:38:37 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBR4caVB006200
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Dec 2007 21:38:37 -0700
Message-ID: <47732C41.7000003@linux.vnet.ibm.com>
Date: Thu, 27 Dec 2007 10:08:25 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: SCSI errors on powerpc with 2.6.24-rc6-mm1
References: <20071224044850.GA11449@linux.vnet.ibm.com>
	<20071227121108L.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20071227121108L.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FUJITA Tomonori wrote:
> On Mon, 24 Dec 2007 10:18:50 +0530
> Balbir Singh <balbir@linux.vnet.ibm.com> wrote:
> 
[snip]

> 
> I might break the IOMMU code. Can you reproduce it easily? If so,
> reverting my IOMMU patches (I've attached a patch to revert them) fix
> the problem?

[snip]


Yes, this patch fixes the problem for me.
Tested-by: Balbir Singh <balbir@linux.vnet.ibm.com>

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
