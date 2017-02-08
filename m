Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJG8s3F7HzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 20:28:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Cc: Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: Fix CPU hotplug to handle waking on
 HVI
In-Reply-To: <1486427731.4850.102.camel@kernel.crashing.org>
References: <1486427731.4850.102.camel@kernel.crashing.org>
Date: Wed, 08 Feb 2017 20:28:12 +1100
Message-ID: <87a89x9glv.fsf@concordia.ellerman.id.au>
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

> The IPIs come in as HVI not EE, so we need to test the appropriate
> SRR1 bits. The encoding is such that it won't have false positives
> on P7 and P8 so we can just test it like that. We also need to handle
> the icp-opal variant of the flush.

Your comment implies that this fix is only required on Power9, but I'm
not 100% clear.

cheers
