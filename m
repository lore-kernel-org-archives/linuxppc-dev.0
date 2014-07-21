Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78FD41A0215
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 18:06:43 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Mon, 21 Jul 2014 13:36:39 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 33F7F1258059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 13:36:28 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6L86uL7197014
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 13:36:56 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6L86Zjw019398
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 13:36:35 +0530
Message-ID: <53CCCA09.1060404@linux.vnet.ibm.com>
Date: Mon, 21 Jul 2014 16:06:33 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <53A91819.1010900@linux.vnet.ibm.com> <1403591761.4587.161.camel@pasglop>
 <53A9216C.8050904@linux.vnet.ibm.com> <1403593252.4587.163.camel@pasglop>
 <20140625000305.GA5742@shangw> <53AA3C5C.4080807@linux.vnet.ibm.com>
 <1403666349.4587.196.camel@pasglop>
In-Reply-To: <1403666349.4587.196.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2014 11:19 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2014-06-25 at 11:05 +0800, Mike Qiu wrote:
>> Here maybe  "/sys/kernel/debug/powerpc/errinjct" is better, because
>> it
>> will supply "PCI_domain_nr" in parameters, so no need supply errinjct
>> for each PCI domain.
>>
>> Another reason is error inject not only for PCI(in future), so better
>> not in PCI domain entry.
>>
>> Also it simple for userland tools to has a fixed path.
> I don't like this. I much prefer have dedicated error injection files
> in their respective locations, something for PCI under the corresponding
> PCI bridge etc...

So PowerNV error injection will be designed rely on debugfs been 
configured, right?

Thanks,
Mike
>
> Cheers,
> Ben.
>
>
>
>
