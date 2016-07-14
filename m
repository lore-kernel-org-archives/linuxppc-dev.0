Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqhYh6TvSzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 13:50:32 +1000 (AEST)
Received: by mail-pf0-x229.google.com with SMTP id c2so25492902pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 20:50:32 -0700 (PDT)
Date: Thu, 14 Jul 2016 13:50:23 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 05/12] powerpc/mm: Clear top 16 bits of va only
 on older cpus
Message-ID: <20160714035023.GD18277@balbir.ozlabs.ibm.com>
Reply-To: bsingharora@gmail.com
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468402531-4914-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468402531-4914-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 03:05:24PM +0530, Aneesh Kumar K.V wrote:
> As per ISA, we need to do this only for architecture version 2.02 and
> earlier. This continued to work even for 2.07. But let's not do this for
> anything after 2.02. ISA 3.0 requires these top bits to be not cleared.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
