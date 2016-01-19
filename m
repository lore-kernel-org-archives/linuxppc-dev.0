Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C198E1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 07:11:34 +1100 (AEDT)
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 19 Jan 2016 18:11:29 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id DE1B03520068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 15:11:19 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0JKC2ST2642168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 18:12:04 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0JKBOHf002934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 18:11:24 -0200
Subject: Re: [PATCH] powerpc/eeh: Validate arch in eeh_add_device_early()
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1452681487.7404.6.camel@ellerman.id.au>
 <56963E40.8070702@linux.vnet.ibm.com>
 <1452720339.8203.4.camel@ellerman.id.au>
 <5697FE17.4070605@linux.vnet.ibm.com>
 <1452814633.19265.1.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, gwshan@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <569E986B.3000506@linux.vnet.ibm.com>
Date: Tue, 19 Jan 2016 18:11:23 -0200
MIME-Version: 1.0
In-Reply-To: <1452814633.19265.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/14/2016 09:37 PM, Michael Ellerman wrote:
>> So, since my patch does not cover this case, I think would be more
>> interesting "unlink" the DDW mechanism from the EEH. It seems easy, I'll
>> try to send you a patch soon.
>>
>> Do you think it is a good approach?
>
> It sounds good, but I don't know off hand whether it will work. See how it goes
> and send us the patch.

You are right (again!). It's kind of complicated to unlink DDW from EEH 
since it relies on EEH to get the config. address of devices.

Instead of try to unlink it, I've inserted an EEH check to avoid issues 
in case DDW can't count on EEH being enabled. Will sent the patches to 
the list.

Thanks very much for your help and comments,



Guilherme
