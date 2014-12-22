Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B8661A0021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 13:56:43 +1100 (AEDT)
In-Reply-To: <1419115353-12374-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: arch: powerpc: platforms: embedded6xx: mpc7448_hpc2.c: Remove
 some unused functions
Message-Id: <20141222025643.53D8A1400E7@ozlabs.org>
Date: Mon, 22 Dec 2014 13:56:43 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-20-12 at 22:42:32 UTC, Rickard Strandqvist wrote:
> Removes some functions that are not used anywhere:
> mpc7448_hpc2_halt() mpc7448_hpc2_power_off()

The other option would be to wire it up.

But the default implementations do more or less the same thing.

As far as I can see these were introduced in c5d56332fd6c "[POWERPC] Add
general support for mpc7448hpc2 (Taiga) platform" and never used.

cheers
