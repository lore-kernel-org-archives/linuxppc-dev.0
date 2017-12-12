Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXR6D1wzDqmM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:19 +1100 (AEDT)
In-Reply-To: <20170131174355.GA25198@dtor-ws>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc/powermac: fix OF node refcount leak
Message-Id: <3ywyXR4Ndmz9t2f@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-01-31 at 17:43:55 UTC, Dmitry Torokhov wrote:
> We need to call of_node_put() for device nodes obtained with
> of_find_node_by_name().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2aaf0a198d7af53a946ad69976d3cc

cheers
