Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDdyr27mBzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 13:07:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/xive: Fix/improve verbose debug output
In-Reply-To: <1493301446.25766.276.camel@kernel.crashing.org>
References: <1493301446.25766.276.camel@kernel.crashing.org>
Date: Fri, 28 Apr 2017 13:07:15 +1000
Message-ID: <87zif1p6vw.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> The existing verbose debug code doesn't build when enabled.

So why don't we convert all the DBG_VERBOSE() to pr_devel()? 

If there's non-verbose debug that we think would be useful to
differentiate from verbose then those could be pr_debug() - which means
they'll be jump labelled off in most production kernels, but still able
to be enabled.

cheers
