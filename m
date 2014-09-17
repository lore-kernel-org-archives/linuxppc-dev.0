Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D073E1A24C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 02:50:46 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 17 Sep 2014 12:50:42 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E596A6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 12:50:26 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8HGocYx6685084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 16:50:38 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8HGocb9032125
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 12:50:38 -0400
Message-ID: <5419BBDE.1060201@linux.vnet.ibm.com>
Date: Wed, 17 Sep 2014 11:50:38 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/5] pseries: Export drc_[acquire|release]_drc() routines
References: <54174C5F.4090604@linux.vnet.ibm.com>
 <1410937625.27681.10.camel@concordia>
In-Reply-To: <1410937625.27681.10.camel@concordia>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/17/2014 02:07 AM, Michael Ellerman wrote:
> 
> On Mon, 2014-09-15 at 15:30 -0500, Nathan Fontenot wrote:
>> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
>> index 361add6..b94516b 100644
>> --- a/arch/powerpc/platforms/pseries/pseries.h
>> +++ b/arch/powerpc/platforms/pseries/pseries.h
>> @@ -59,6 +59,8 @@ extern void dlpar_free_cc_property(struct property *);
>>  extern struct device_node *dlpar_configure_connector(u32, struct device_node *);
>>  extern int dlpar_attach_node(struct device_node *);
>>  extern int dlpar_detach_node(struct device_node *);
>> +extern int dlpar_acquire_drc(u32);
>> +extern int dlpar_release_drc(u32);
> 
> Please name the parameters.

Will do.

> 
> And don't bother with extern.

I was following the convention used in the file, droppping the
extern is fine with me though.

-Nathan
