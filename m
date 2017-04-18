Return-Path: <rientjes@google.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6z1p2Ws1zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 07:35:09 +1000 (AEST)
Received: by mail-pf0-x235.google.com with SMTP id a188so2481718pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 14:35:09 -0700 (PDT)
Date: Tue, 18 Apr 2017 14:35:06 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Oliver O'Halloran <oohall@gmail.com>
cc: linuxppc-dev@lists.ozlabs.org, arbab@linux.vnet.ibm.com,
 bsingharora@gmail.com, linux-nvdimm@lists.01.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-mm@kvack.org
Subject: Re: [PATCH 1/9] mm/huge_memory: Use zap_deposited_table() more
In-Reply-To: <20170411174233.21902-2-oohall@gmail.com>
Message-ID: <alpine.DEB.2.10.1704181434520.112481@chino.kir.corp.google.com>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-2-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Apr 2017, Oliver O'Halloran wrote:

> Depending flags of the PMD being zapped there may or may not be a
> deposited pgtable to be freed. In two of the three cases this is open
> coded while the third uses the zap_deposited_table() helper. This patch
> converts the others to use the helper to clean things up a bit.
> 
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
