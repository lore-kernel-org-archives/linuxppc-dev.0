Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F4DD1A0740
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 05:06:58 +1100 (AEDT)
Date: Tue, 31 Mar 2015 14:06:42 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: sparclinux@vger.kernel.org
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
Message-ID: <20150331180642.GA13314@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1427761300.git.sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (03/31/15 10:40), Sowmini Varadhan wrote:
> 
> I've not heard back from the IB folks, but I'm going to make
> a judgement call here and go with the spin_lock. *If* they
> report some significant benefit from the trylock, probably 
> need to revisit this (and then probably start by re-exmaining
> the hash function to avoid collisions, before resorting to 
> trylock).

Having bravely said that..

the IB team informs me that they see a 10% degradation using 
the spin_lock as opposed to the trylock.

one path going forward is to continue processing this patch-set 
as is. I can investigate this further, and later revise the spin_lock
to the trylock, after we are certain that it is good/necessary.

thoughts?

--Sowmini
