Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id CFFD01A09F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 05:12:39 +1100 (AEDT)
Date: Wed, 25 Mar 2015 14:12:35 -0400 (EDT)
Message-Id: <20150325.141235.238730018688792495.davem@davemloft.net>
To: sowmini.varadhan@oracle.com
Subject: Re: [PATCH v7 0/3] Generic IOMMU pooled allocator
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1427295804.git.sowmini.varadhan@oracle.com>
References: <cover.1427295804.git.sowmini.varadhan@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 25 Mar 2015 13:34:45 -0400

> Changes from patchv6: moved pool_hash initialization to
> lib/iommu-common.c and cleaned up code duplication from 
> sun4v/sun4u/ldc. 

Looks good to me.

PowerPC folks, what do you think?
