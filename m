Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 802BC1A0087
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 10:54:39 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 23 Sep 2014 10:54:38 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EAD0E357804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 10:54:34 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8N0aFWl56688640
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 10:36:24 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8N0s1GF021640
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 10:54:01 +1000
Date: Tue, 23 Sep 2014 10:53:39 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 0/2] powerpc: pci-ioda: Neatening
Message-ID: <20140923005339.GA7740@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <cover.1411320262.git.joe@perches.com>
 <1411368977.16867.11.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411368977.16867.11.camel@concordia>
Cc: Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 22, 2014 at 04:56:17PM +1000, Michael Ellerman wrote:
>On Sun, 2014-09-21 at 10:55 -0700, Joe Perches wrote:
>> printk calls should return void
>> 
>> Joe Perches (2):
>>   powerpc: pci-ioda: Remove unnecessary return value from printk
>>   powerpc: pci-ioda: Use a single function to emit logging messages
>
>Patches look good to me.
>

Patches look good to me too.

>Ben/Gavin, what do these macros give us over pr/dev_debug() ?
>

Those macros prints unified mapping information between
PE number and PCI device/bus.

Thanks,
Gavin

>cheers
>
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
