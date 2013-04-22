Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BCFF2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:48:30 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 11:12:18 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 69D7DE0059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 11:20:13 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3M5m7ws5833150
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 11:18:07 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3M5mAn6014106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:48:11 +1000
Message-ID: <5174CF10.70903@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 11:18:00 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH RESEND] powerpc/rtas_flash: Free kmem upon module exit
References: <20130419114737.20439.54937.stgit@hegdevasant>
 <20130421232757.GA22246@concordia>
In-Reply-To: <20130421232757.GA22246@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael,

On Mon 22 Apr 2013 04:57:57 AM IST, Michael Ellerman wrote:
> On Fri, Apr 19, 2013 at 05:18:09PM +0530, Vasant Hegde wrote:
>> Memory allocated to flash_block_list in rtas_flash_write
>> is not freed during module exit. We hit below call trace
>> if we unload rtas_flash module after loading new firmware
>> image and before rebooting the system.
>
> Why the resend? Did anything change?
>

Nothing is changed. I resent because it was not reviewed for long time.

-Vasant

> cheers
>
