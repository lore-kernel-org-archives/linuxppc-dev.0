Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F2241A1F44
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 15:00:15 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 9 Sep 2015 15:00:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 19FE32BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 15:00:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t89500po61145218
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Sep 2015 15:00:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t894xZvP014326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Sep 2015 14:59:36 +1000
Message-ID: <1441774751.2767.20.camel@au1.ibm.com>
Subject: Re: [PATCH V9 11/11] powerpc/powernv: compound PE for VFs
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Richard Yang <weiyang@linux.vnet.ibm.com>, Gavin Shan
 <gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, linux-pci@vger.kernel.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 09 Sep 2015 14:59:11 +1000
In-Reply-To: <20150909033616.GA5148@richards-mbp.cn.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1437112961-17275-12-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150729031718.GA18069@richard> <20150909024820.GA6808@gwshan>
 <20150909033616.GA5148@richards-mbp.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-09 at 11:36 +0800, Richard Yang wrote:
> The VF EEH is hung since we re-designed the SRIOV. After the re
> -design, we
> don't have VF groups.
> 
> My plan is to push the VF EEH patch set after the SRIOV Redesign is
> accepted.

What do you mean taht we don't have VF groups ?

If we don't have IOMMU groups per VF that means we can't assign them to
KVM partitions -> they are completely useless.

Ben.
