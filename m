Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C426F1A0A9C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 08:52:06 +1100 (AEDT)
Date: Fri, 3 Apr 2015 17:51:54 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
Message-ID: <20150403215154.GK26158@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150403182852.GI26158@oracle.com>
 <1428095210.20500.291.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428095210.20500.291.camel@kernel.crashing.org>
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

On (04/04/15 08:06), Benjamin Herrenschmidt wrote:
> 
> No, I meant "n < pool->hint", ie, the start of the newly allocated
> block.

ah, got it. I'll do my drill with patchset and get back, probably by
Monday.

--Sowmini
