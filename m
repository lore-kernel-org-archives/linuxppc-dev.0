Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPSyh2pRtzDw5h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 16:52:12 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 3so2626489pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 21:52:12 -0800 (PST)
Subject: Re: [RFC][PATCH] Update ppc disassembly in xmon
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <6229e33e-2d6e-25d8-4206-2b62f3a11500@gmail.com>
 <9f8b3a9a-3744-6452-5c33-bcf0cdbdaa21@au1.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <75641461-a8c1-075f-c7f6-0cee6f29f379@gmail.com>
Date: Thu, 24 Nov 2016 16:52:18 +1100
MIME-Version: 1.0
In-Reply-To: <9f8b3a9a-3744-6452-5c33-bcf0cdbdaa21@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24/11/16 16:14, Andrew Donnellan wrote:
> On 24/11/16 13:05, Balbir Singh wrote:
>> 9. The license for these files is now GPL v3 or later
> 
> As much as I love the GPLv3, isn't this an instant NAK?
> 

Thats why I called it out, my bad though I should have done
a stronger check than just "git grep "version 3"" which matched
scripts/kconfig/zconf.tab.c_shipped -- derived from bison, which
can itself be licensed differently

Michael, please hold these patches and don't merge them yet.

Balbir Singh.
