Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s41cN4vfjzDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 15:20:36 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id cf3so13262914pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 22:20:36 -0700 (PDT)
Message-ID: <1470201642.5034.3.camel@gmail.com>
Subject: Re: [PATCH 2/2] fadump: Disable deferred page struct initialisation
From: Balbir Singh <bsingharora@gmail.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-mm@kvack.org, Mel
 Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@kernel.org>, Andrew Morton
 <akpm@linux--foundation.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 03 Aug 2016 15:20:42 +1000
In-Reply-To: <1470143947-24443-3-git-send-email-srikar@linux.vnet.ibm.com>
References: <1470143947-24443-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1470143947-24443-3-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-02 at 18:49 +0530, Srikar Dronamraju wrote:
> Fadump kernel reserves significant number of memory blocks. On a multi-node
> machine, with CONFIG_DEFFERRED_STRUCT_PAGE support, fadump kernel fails to
> boot. Fix this by disabling deferred page struct initialisation.
> 

How much memory does a fadump kernel need? Can we bump up the limits depending
on the config. I presume when you say fadump kernel you mean kernel with
FADUMP in the config?

BTW, I would much rather prefer a config based solution that does not select
DEFERRED_INIT if FADUMP is enabled.

Balbir
