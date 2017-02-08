Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJDWR06z6zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 19:14:09 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id e4so11150500pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 00:14:09 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 8 Feb 2017 13:44:01 +0530
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powerpc/mm: Fix typo in set_pte_at()
Message-ID: <20170208081401.GB17068@localhost.localdomain>
References: <1486523810-21112-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486523810-21112-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 08, 2017 at 02:16:50PM +1100, Gavin Shan wrote:
> This fixes the typo about the _PAGE_PTE in set_pte_at() by changing
> "tryint" to "trying to".
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> v2: Removed "Fixes" tag

Not much to ack, but

Acked-by: Balbir Singh <bsingharora@gmail.com>
