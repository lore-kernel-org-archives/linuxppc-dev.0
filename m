Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C61ED1A0175
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 16:57:55 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Tue, 24 Jun 2014 16:57:54 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0D8D22CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 16:57:52 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5O6fUms38535368
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 16:41:31 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5O6voep030531
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 16:57:51 +1000
Message-ID: <53A9216C.8050904@linux.vnet.ibm.com>
Date: Tue, 24 Jun 2014 14:57:48 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <53A91819.1010900@linux.vnet.ibm.com> <1403591761.4587.161.camel@pasglop>
In-Reply-To: <1403591761.4587.161.camel@pasglop>
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

On 06/24/2014 02:36 PM, Benjamin Herrenschmidt wrote:
>> Is it reasonable to do error injection with "CONFIG_IOMMU_API" ?
>>
>> That means if use default config(CONFIG_IOMMU_API = n),  we can not do
>> error injection to pci devices?
> Well we can't pass them through either so ...
> In any case, this is not a priority. First we need to implement a solid
> error injection facility for the *host*. The guest one is really really

OK.

Is that mean *host* side error injection should base on 
"CONFIG_IOMMU_API" ? If it is just host side(no guest, no pass through), 
can't we do error inject?

Maybe I misunderstand :)

Thanks
Mike
> low on the list.
>
> Cheers,
> Ben.
>
>
>
