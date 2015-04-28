Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 262DC1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 21:07:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 16:37:04 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0FE44394005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 16:37:00 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SB6x0P64291024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 16:36:59 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SB6QPf009310
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 16:36:27 +0530
Message-ID: <553F69B2.1030602@linux.vnet.ibm.com>
Date: Tue, 28 Apr 2015 16:36:26 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150422234509.626d9dc7@ja.home>
 <55388254.4000606@linux.vnet.ibm.com> <20150423161342.55e9ac8f@ja.home>
 <1430086038.16571.78.camel@kernel.crashing.org>
 <553DE41A.5070703@samsung.com>
 <1430128435.16571.110.camel@kernel.crashing.org>
 <553E1A65.5080409@samsung.com> <553E3E06.6070605@linux.vnet.ibm.com>
In-Reply-To: <553E3E06.6070605@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/27/2015 07:17 PM, Vasant Hegde wrote:
> On 04/27/2015 04:45 PM, Jacek Anaszewski wrote:
>> On 04/27/2015 11:53 AM, Benjamin Herrenschmidt wrote:
>>> On Mon, 2015-04-27 at 09:24 +0200, Jacek Anaszewski wrote:
>>>> I was not aware that some other entity than the driver could be
>>>> interested in the information provided by DT node. I will no longer
>>>> object, provided that we will get an ack from DT maintainer.
>>>
> 
> Jacket,

Oops.. Sorry..  It was a typo .. I meant Jacek..


-Vasant
