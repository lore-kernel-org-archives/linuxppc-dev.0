Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJh2137kTzDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 14:52:57 +1000 (AEST)
Message-ID: <1464670358.3078.246.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc/pseries: Drop support for MPIC in pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rashmica <rashmicy@gmail.com>, mpe@ellerman.id.au, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 31 May 2016 14:52:38 +1000
In-Reply-To: <574CFB67.7000605@gmail.com>
References: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
 <1464593541.3078.192.camel@kernel.crashing.org>
 <574CEA20.5070809@gmail.com> <574CFB67.7000605@gmail.com>
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

On Tue, 2016-05-31 at 12:48 +1000, Rashmica wrote:
> 
> Oliver just informed me that it is only replacing XICS for p9. Should
> I leave this for the person adding in the XIVE code?

That would be me ;-) It will cost you a beer !

Cheers,
Ben.
