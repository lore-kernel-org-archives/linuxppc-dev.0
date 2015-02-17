Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19ACC1A08B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 09:27:17 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E7A9D1401DD
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 09:27:16 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 18 Feb 2015 08:27:16 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 49CCA3578048
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 09:27:14 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HMR5SV43581574
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 09:27:14 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HMQe2q020066
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 09:26:40 +1100
Date: Wed, 18 Feb 2015 09:26:15 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND v2 0/7] powerpc/powernv: Unified PCI slot reset
 and hotplug
Message-ID: <20150217222615.GA6454@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <m3vbj0gqmk.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3vbj0gqmk.fsf@oc8180480414.ibm.com>
Cc: bhelgaas@google.com, linuxppc-dev@ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 18, 2015 at 08:44:19AM +1100, Stewart Smith wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> The patchset was built based on patchset "powerpc/powernv: Simplify EEH
>> implementation", which can be found from:
>>
>> https://patchwork.ozlabs.org/patch/439956/
>>
>> The patchset corresponds to skiboot changes, which manages PCI slots
>> in a unified way: OPAL APIs used to do slot reset, power management,
>> presence status retrival. The patchset shouldn't be merged before
>> the OPAL firmware counterpart is merged:
>>
>> https://patchwork.ozlabs.org/patch/440463/
>
>But this patchset will work with old OPAL, right? We're not breaking
>compatibility with newer kernels (with this patchset) and older
>firmware?

Yes. With old OPAL, the reset stuff in Linux works as before and we
shouldn't see hotpluggable slots from /sys/bus/pci/slots.

The compatibility issue was pointed by Ben. It's something fixed by
this revision (v2).

Thanks,
Gavin
