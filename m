Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420cKT1dQZzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 17:13:17 +1000 (AEST)
Message-ID: <3c36e64e64742e79b72faf1f52a3c1fb2b3d1983.camel@neuling.org>
Subject: Re: [PATCH v7 1/2] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
From: Michael Neuling <mikey@neuling.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Srikar Dronamraju
 <srikar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Murilo Opsfelder Araujo
 <muriloo@linux.ibm.com>, Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Aug 2018 17:13:16 +1000
In-Reply-To: <61048333bca549ffa275bf32eeb1a2480340a7e0.camel@neuling.org>
References: <1534743704-4760-1-git-send-email-ego@linux.vnet.ibm.com>
 <1534743704-4760-2-git-send-email-ego@linux.vnet.ibm.com>
 <61048333bca549ffa275bf32eeb1a2480340a7e0.camel@neuling.org>
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

On Wed, 2018-08-29 at 17:04 +1000, Michael Neuling wrote:
> > +What: 		/sys/devices/system/cpu/cpu[0-9]+/small_core_siblings
>=20
> Shouldn't we put this in the topology/ subdir with with the other items l=
ike
> it?

Also, please follow the same format as *_sibilings files topology/ where th=
ey
are just a mask (this patch currently has it as a comma separated list).

Mikey
