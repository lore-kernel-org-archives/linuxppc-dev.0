Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C95D81A0682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 08:05:59 +1100 (AEDT)
Message-ID: <1427317542.6468.85.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 0/3] Generic IOMMU pooled allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Thu, 26 Mar 2015 08:05:42 +1100
In-Reply-To: <20150325.141235.238730018688792495.davem@davemloft.net>
References: <cover.1427295804.git.sowmini.varadhan@oracle.com>
 <20150325.141235.238730018688792495.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, sowmini.varadhan@oracle.com, anton@au1.ibm.com,
 paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-25 at 14:12 -0400, David Miller wrote:
> From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Date: Wed, 25 Mar 2015 13:34:45 -0400
> 
> > Changes from patchv6: moved pool_hash initialization to
> > lib/iommu-common.c and cleaned up code duplication from 
> > sun4v/sun4u/ldc. 
> 
> Looks good to me.
> 
> PowerPC folks, what do you think?

I'll give it another look today.

Cheers,
Ben.
