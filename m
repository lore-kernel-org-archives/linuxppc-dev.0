Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FA9F1A2750
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 15:53:37 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 9 Sep 2015 11:23:34 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CABD23940060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 11:23:31 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t895rV2C40501364
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Sep 2015 11:23:31 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t895rUT0020515
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Sep 2015 11:23:31 +0530
Date: Wed, 9 Sep 2015 13:53:29 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, aik@ozlabs.ru,
 linux-pci@vger.kernel.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V9 11/11] powerpc/powernv: compound PE for VFs
Message-ID: <20150909055329.GA7684@Richards-MacBook-Pro.local>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1437112961-17275-12-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150729031718.GA18069@richard> <20150909024820.GA6808@gwshan>
 <20150909033616.GA5148@richards-mbp.cn.ibm.com>
 <1441774751.2767.20.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441774751.2767.20.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 09, 2015 at 02:59:11PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2015-09-09 at 11:36 +0800, Richard Yang wrote:
>> The VF EEH is hung since we re-designed the SRIOV. After the re
>> -design, we
>> don't have VF groups.
>> 
>> My plan is to push the VF EEH patch set after the SRIOV Redesign is
>> accepted.
>
>What do you mean taht we don't have VF groups ?
>

Before we redesign the SRIOV, several VFs may share one M64 segment. This
introduced the compound PE for VFs. The VF group in previous mail means the
compound PE composed of a master VF PE will have several slave VF PEs.

>If we don't have IOMMU groups per VF that means we can't assign them to
>KVM partitions -> they are completely useless.

Yes, I don't mean for the IOMMU group.

>
>Ben.

-- 
Richard Yang
Help you, Help me
