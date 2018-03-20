Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40582W1cBjzF0n6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 21:15:31 +1100 (AEDT)
In-Reply-To: <20180228224406.7049-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'
Message-Id: <40582V6byxz9sZ5@ozlabs.org>
Date: Tue, 20 Mar 2018 21:15:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-02-28 at 22:44:06 UTC, Rob Herring wrote:
> 'linux,stdout-path' has been deprecated for some time in favor of
> 'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
> Search and replace all the of occurrences with 'stdout-path'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/78e5dfea84dc15d69940831b3981b3

cheers
