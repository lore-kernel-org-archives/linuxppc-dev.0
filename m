Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqj1V1Lr0zDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 14:11:10 +1000 (AEST)
Received: by mail-pa0-x229.google.com with SMTP id pp5so17478994pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 21:11:10 -0700 (PDT)
Date: Thu, 14 Jul 2016 14:10:58 +1000
From: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2][PATCH] KVM: PPC: Book3S HV: Migrate pinned pages out of CMA
Message-ID: <20160714041058.GF18277@balbir.ozlabs.ibm.com>
Reply-To: bsingharora@gmail.com
References: <57d99598-2350-9578-5f93-b551cda12d23@ozlabs.au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57d99598-2350-9578-5f93-b551cda12d23@ozlabs.au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 14, 2016 at 01:11:03PM +1000, Balbir Singh wrote:
> 
>

The from address is bad, resending with the right email address 
