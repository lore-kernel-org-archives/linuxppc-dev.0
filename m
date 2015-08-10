Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66E4E1A0935
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:27:02 +1000 (AEST)
In-Reply-To: <1438344860.13223.14.camel@tiscali.nl>
To: Paul Bolle <pebolle@tiscali.nl>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: windfarm: remove three exported but unused functions
Message-Id: <20150810092702.1CB2B14055A@ozlabs.org>
Date: Mon, 10 Aug 2015 19:27:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-31-07 at 12:14:20 UTC, Paul Bolle wrote:
> wf_find_control(), wf_find_sensor(), and wf_is_overtemp() are exported
> but unused. Remove these three functions.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a368c29cf105485d2c34

cheers
