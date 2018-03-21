Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405bwh2bbxzDqHy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 15:12:03 +1100 (AEDT)
Message-ID: <1521605505.16434.264.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: Fix lost pending interrupt due to race
 causing lost update to irq_happened
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Carol L. Soto" <clsoto@us.ibm.com>
Date: Wed, 21 Mar 2018 15:11:45 +1100
In-Reply-To: <20180321131615.7b8bd8e4@roar.ozlabs.ibm.com>
References: <20180321022228.9606-1-npiggin@gmail.com>
 <1521599548.16434.263.camel@kernel.crashing.org>
 <20180321131615.7b8bd8e4@roar.ozlabs.ibm.com>
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

On Wed, 2018-03-21 at 13:16 +1000, Nicholas Piggin wrote:
> Yes Carol is working on this with distros. Backporting should be
> simple, so hoping to get this upstream soon to help the process.
> We can take that as a Reviewed-by:? :)

Ah yup.

Cheers,
Ben.
