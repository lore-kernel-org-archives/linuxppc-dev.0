Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GP0r5dTCzDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 21:31:08 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id g20-v6so13508851plo.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 04:31:08 -0700 (PDT)
Date: Wed, 4 Apr 2018 21:30:56 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: Re: [RESEND v2 1/4] libnvdimm: Add of_node to region and bus
 descriptors
Message-ID: <20180404213056.3ef5bd66@gmail.com>
In-Reply-To: <20180403142415.30083-1-oohall@gmail.com>
References: <20180403142415.30083-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  4 Apr 2018 00:24:12 +1000
Oliver O'Halloran <oohall@gmail.com> wrote:

> We want to be able to cross reference the region and bus devices
> with the device tree node that they were spawned from. libNVDIMM
> handles creating the actual devices for these internally, so we
> need to pass in a pointer to the relevant node in the descriptor.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> ---
Acked-by: Balbir Singh <bsingharora@gmail.com>
