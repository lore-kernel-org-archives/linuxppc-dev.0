Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAFA91A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 12:22:32 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 28 Oct 2015 06:51:35 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 714851258019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 06:51:27 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9S1LVLW12517854
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 06:51:32 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9S1LV4C005914
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 06:51:31 +0530
Date: Wed, 28 Oct 2015 09:21:22 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 01/12] PCI/IOV: Rename and export
 virtfn_add/virtfn_remove
Message-ID: <20151028012122.GA16965@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <20151027230654.GA5155@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151027230654.GA5155@localhost>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 27, 2015 at 06:06:54PM -0500, Bjorn Helgaas wrote:
>On Mon, Oct 26, 2015 at 11:15:51AM +0800, Wei Yang wrote:
>> During EEH recovery, hotplug is applied to the devices which don't
>> have drivers or their drivers don't support EEH. However, the hotplug,
>> which was implemented based on PCI bus, can't be applied to VF directly.
>> 
>> The patch renames virtn_{add,remove}() and exports them so that they
>> can be used in PCI hotplug during EEH recovery.
>
>Trivial, but write this as an imperative sentence, e.g.,
>
>  Rename virtn_{add,remove}() and export them so they
>  can be used in PCI hotplug during EEH recovery.
>
>"The patch" doesn't add any useful information; it's obvious that the
>changelog applied to this patch.

Yep, thanks, will change in next version.

>
>This comment also applies to at least the next patch.
>
>Bjorn

-- 
Richard Yang
Help you, Help me
