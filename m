Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D05321A0144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 20:35:17 +1000 (AEST)
In-Reply-To: <20150825054110.GD3815@in.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Add user-return-notifier support
Message-Id: <20150831103517.96D1A1401E7@ozlabs.org>
Date: Mon, 31 Aug 2015 20:35:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-25-08 at 05:41:10 UTC, Ananth N Mavinakayanahalli wrote:
> Add user return notifier support for powerpc. Similar to x86, this feature
> keys off of the KVM Kconfig.

Please flesh this out.

What is it, why do we want it, why is your implementation correct.

cheers
