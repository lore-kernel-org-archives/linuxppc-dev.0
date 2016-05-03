Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzYpJ3Lw2zDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:13:28 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id yl2so856707pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 May 2016 01:13:28 -0700 (PDT)
Subject: Re: [RFC 4/7] powerpc/mm: Set MAX_ZONE_PFN to 0 for all zones beyond
 TOP_ZONE
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1462256966-19321-5-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, oohall@gmail.com, aneesh.kumar@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57285DA2.7040404@gmail.com>
Date: Tue, 3 May 2016 18:13:22 +1000
MIME-Version: 1.0
In-Reply-To: <1462256966-19321-5-git-send-email-khandual@linux.vnet.ibm.com>
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
> From: Oliver O'Halloran <oohall@gmail.com>
> 
> All the memory zones past TOP_ZONE are managed by generic mm code. Zone
> max PFN should be set to 0 instead of ~0UL since that's what the generic
> mm code expects. Without this, kernel assigns all pages into ZONE_DEVICE
> zone which is not part of buddy allocator, hence kernel cannot allocate
> any memory and even fails to boot.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
