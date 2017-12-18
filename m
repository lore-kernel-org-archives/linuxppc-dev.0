Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0qBx4CbXzDqZC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 05:22:33 +1100 (AEDT)
Subject: Re: [PATCH 1/2] ps3: Delete an error message for a failed memory
 allocation in two functions
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
 <58807b28-b2b9-7e77-11b8-21db43c9d5ba@users.sourceforge.net>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <1fb2955d-7233-7069-7c4b-316a4eb764f0@infradead.org>
Date: Mon, 18 Dec 2017 10:22:18 -0800
MIME-Version: 1.0
In-Reply-To: <58807b28-b2b9-7e77-11b8-21db43c9d5ba@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/16/2017 05:51 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 16 Dec 2017 12:32:42 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.

This is OK, I'll add it to my ps3-queue branch.

-Geoff
