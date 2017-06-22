Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtgbQ1WXHzDr1t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 22:18:26 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MCFXJf008551
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 08:18:24 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8dhw0m38-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 08:18:24 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 13:18:21 +0100
Subject: Re: [PATCH V3] cxl: Export library to support IBM XSL
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 fbarrat@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1498039393-10656-1-git-send-email-clombard@linux.vnet.ibm.com>
 <87wp84qnf4.fsf@concordia.ellerman.id.au>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 14:18:18 +0200
MIME-Version: 1.0
In-Reply-To: <87wp84qnf4.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5ea5d012-9d3a-fea8-e339-9b0a7c1f786e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 22/06/2017 à 13:20, Michael Ellerman a écrit :
> Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
>
>> This patch exports a in-kernel 'library' API which can be called by
>> other drivers to help interacting with an IBM XSL on a POWER9 system.
>>
>> The XSL (Translation Service Layer) is a stripped down version of the
>> PSL (Power Service Layer) used in some cards such as the Mellanox CX5.
>> Like the PSL, it implements the CAIA architecture, but has a number
>> of differences, mostly in it's implementation dependent registers.
>>
>> The XSL also uses a special DMA cxl mode, which uses a slightly
>> different init sequence for the CAPP and PHB.
>>
>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Andrew sent you a SOB for parts he wrote, so you should include that.
>
> Waiting for an ack from Fred before I merge this.
>
> cheers
>

You are right (Sorry Andrew !). I will push a new patch

Thanks
