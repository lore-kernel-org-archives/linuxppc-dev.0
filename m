Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 7A8481A2B03
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 06:05:16 +1100 (AEDT)
Date: Mon, 23 Mar 2015 15:05:08 -0400 (EDT)
Message-Id: <20150323.150508.149509757161802782.davem@davemloft.net>
To: sowmini.varadhan@oracle.com
Subject: Re: Generic IOMMU pooled allocator
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150323165406.GG14061@oracle.com>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org,
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
Date: Mon, 23 Mar 2015 12:54:06 -0400

> If it was only an optimization (i.e., removing it would not break
> any functionality), and if this was done for older hardware,
> and *if* we believe that the direction of most architectures is to 
> follow the sun4v/HV model, then, given that the sun4u code only uses 1 
> arena pool anyway, one thought that I have for refactoring this
> is the following:

Why add performance regressions to old machines who already are
suffering too much from all the bloat we are constantly adding to the
kernel?
