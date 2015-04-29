Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99E7B1A0025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:22:41 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D283D14032B
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2015 15:22:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 29 Apr 2015 10:52:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 04F68E0057
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2015 10:55:22 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3T5MaYM2949432
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2015 10:52:36 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3T5MZEa019174
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2015 10:52:36 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@ozlabs.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 0/4] PCI: Generic fixes and moving enumeration back to
 QEMU
In-Reply-To: <55404C16.5040008@ozlabs.ru>
References: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <55404C16.5040008@ozlabs.ru>
Date: Wed, 29 Apr 2015 10:52:35 +0530
Message-ID: <87y4lby0dg.fsf@abhimanyu.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> On 04/27/2015 06:02 PM, Nikunj A Dadhania wrote:
>> patch 1:   Fixes a bug in pci-to-pci bridge while programming the limit
>>             registers during probe
>> patch 2,3: Support 64-bit address translation and usb devices can have
>>        	   64-bit pci memory BARs
>> patch 4:   Use QEMU create device tree nodes and program the BARs
>
>
>
> I taught my "git send-email" wrapper script to add "kernel/qemu/slof" in 
> the subject, otherwise I believe it is hard for busy people to tell quickly 
> what patchset is for what, I'd recommend you doing the same, especially 
> when you mention "QEMU" in a subject  :)

Adding in the Subject will put "slof" in the commit title, which is what
we do not want. So will add SLOF in the "[ ]" now onwards. Something
like this: "[ PATCH SLOF <version> ]"

Regards
Nikunj
