Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCKXk6tXqzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 07:44:22 +1100 (AEDT)
Subject: Re: [PATCH] ps3_gelic_net: Delete an error message for a failed
 memory allocation in gelic_descr_prepare_rx()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <9613bfbf-11cc-1e66-484a-84fcda022861@users.sourceforge.net>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <611a3611-a5ef-9681-7b60-77b83922d6c9@infradead.org>
Date: Thu, 4 Jan 2018 12:44:00 -0800
MIME-Version: 1.0
In-Reply-To: <9613bfbf-11cc-1e66-484a-84fcda022861@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/03/2018 06:40 AM, SF Markus Elfring wrote:
> Omit an extra message for a memory allocation failure in this function.

I applied this to my ps3-queue branch.

As I mentioned to you several times before, please keep
the commit subject line to less than 50 characters.
Also, in this case the prefix would be 'net/ps3_gelic_net:"

-Geoff
