Return-Path: <srs0=vapb=fw=gate.crashing.org=segher@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrzPF5rK4zF13m
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 02:04:33 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zrzPF36ZYz8t8b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 02:04:33 +1100 (AEDT)
Date: Wed, 28 Feb 2018 09:04:27 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH 1/6] powerpc: Add security feature flags for
 Spectre/Meltdown
Message-ID: <20180228150427.GA21977@gate.crashing.org>
References: <20180228145316.11347-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180228145316.11347-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Thu, Mar 01, 2018 at 01:53:11AM +1100, Michael Ellerman wrote:
> +// A speculation barrier should be used for bounds checks (Spectre variant 1ull

s/1ull/1)/  ?


Segher
