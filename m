Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5A601A0145
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 12:01:49 +1100 (AEDT)
Message-ID: <1427850091.20500.150.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 01 Apr 2015 12:01:31 +1100
In-Reply-To: <20150331180642.GA13314@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <20150331180642.GA13314@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-31 at 14:06 -0400, Sowmini Varadhan wrote:
> Having bravely said that..
> 
> the IB team informs me that they see a 10% degradation using 
> the spin_lock as opposed to the trylock.
> 
> one path going forward is to continue processing this patch-set 
> as is. I can investigate this further, and later revise the spin_lock
> to the trylock, after we are certain that it is good/necessary.

Have they tried using more pools instead ?

Cheers,
Ben.
