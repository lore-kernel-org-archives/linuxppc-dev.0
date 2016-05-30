Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ7cm44CDzDqRG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 17:32:40 +1000 (AEST)
Message-ID: <1464593541.3078.192.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc/pseries: Drop support for MPIC in pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rashmica Gupta <rashmicy@gmail.com>, mpe@ellerman.id.au, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 30 May 2016 17:32:21 +1000
In-Reply-To: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
References: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
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

On Mon, 2016-05-30 at 16:18 +1000, Rashmica Gupta wrote:
> MPIC was only used by Power3 which is now unsupported, so drop support
> for MPIC. XICS is now the only supported interrupt controller for
> pSeries so make the XICS functions generic.

The second half I'm not sure ... XIVE is around the corner...

Cheers,
Ben.
