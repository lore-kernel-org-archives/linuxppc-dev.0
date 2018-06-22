Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41C59z0GYczF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 03:27:50 +1000 (AEST)
Date: Fri, 22 Jun 2018 12:27:41 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Document issues with TM on POWER9
Message-ID: <20180622172741.GR16221@gate.crashing.org>
References: <20180622061452.19016-1-mikey@neuling.org>
 <20180622061452.19016-2-mikey@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180622061452.19016-2-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 22, 2018 at 04:14:52PM +1000, Michael Neuling wrote:
> +degredation. Host userspace has TM disabled

"degradation"

> +POWER9C DD1.2 and above are only avaliable with POWERNV and hence

"available"


Segher
