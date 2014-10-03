Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93A701A0A5E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 16:40:21 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 3 Oct 2014 16:40:20 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6A0212BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 16:40:18 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s936gCPA16580632
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 16:42:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s936eHCP006980
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 16:40:17 +1000
Date: Fri, 3 Oct 2014 16:40:17 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [1/4] powerpc/powernv: Sync header with firmware
Message-ID: <20141003064017.GA16907@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20140925042747.8E2AE14016A@ozlabs.org>
 <m3a95dhg94.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3a95dhg94.fsf@oc8180480414.ibm.com>
Cc: qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 03, 2014 at 03:30:31PM +1000, Stewart Smith wrote:
>Michael Ellerman <mpe@ellerman.id.au> writes:
>>> +	OpalEjtIoaDmaWriteMemTarget	= 19,
>>> +};
>>
>> I realise these come from the skiboot source, but they're just too ugly.
>>
>> Please use kernel style naming, like most of the rest of the file, eg:
>>
>> 	OPAL_ERR_INJECT_IOA_BUS_ERR
>
>You know what, I think I'd feel better if we changed skiboot source to
>be like this too. Many of the other enums in skiboot are kernel style
>and not camel. So, I'm going to go do that, then kernel and firmware can
>match.

Yes, for the PCI error types/functions, I sent one patch to make skiboot
looks same to kernel yesterday.

Thanks,
Gavin
