Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzZ0C0jYfzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:22:03 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id gh9so883981pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 May 2016 01:22:03 -0700 (PDT)
Subject: Re: [RFC 7/7] TEST: Driver to test device memory through ZONE_DEVICE
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1462256966-19321-8-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, oohall@gmail.com, aneesh.kumar@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57285FA4.70408@gmail.com>
Date: Tue, 3 May 2016 18:21:56 +1000
MIME-Version: 1.0
In-Reply-To: <1462256966-19321-8-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/05/16 16:29, Anshuman Khandual wrote:
> This is an example driver with little bit of kernel hack to test
> ZONE_DEVICE based device memory management on POWER.
> 

I think this should be under CONFIG_DEBUG/CONFIG_DEBUG_VM or something
No?

If you are exporting the functions from the previous patch just for the
test driver, we might want tor refactor the code

Balbir
