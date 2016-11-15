Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHyw76N2czDt0c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 18:00:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, tj@kernel.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v1 3/3] powerpc: fix node_possible_map limitations
In-Reply-To: <1479167045-28136-4-git-send-email-bsingharora@gmail.com>
References: <1479167045-28136-1-git-send-email-bsingharora@gmail.com>
 <1479167045-28136-4-git-send-email-bsingharora@gmail.com>
Date: Tue, 15 Nov 2016 18:00:52 +1100
Message-ID: <8760npz0pn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Can you make the subject a bit more descriptive?

Currently this prevents node hotplug, so it's required that we remove it
to support that IIUIC.

Balbir Singh <bsingharora@gmail.com> writes:
> We've fixed the memory hotplug issue with memcg, hence
> this work around should not be required.
>
> Fixes: commit 3af229f2071f
> ("powerpc/numa: Reset node_possible_map to only node_online_map")

I don't think Fixes is right here, that commit wasn't buggy, it was just
a workaround for the code at that time.

Just say "This is a revert of commit 3af229f2071f ("powerpc/numa: Reset
node_possible_map to only node_online_map")".

Otherwise LGTM to go via mm.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
