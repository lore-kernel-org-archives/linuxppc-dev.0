Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03C081A0741
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2015 01:20:31 +1100 (AEDT)
Message-ID: <1445088290.24309.60.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/mm: Add page soft dirty tracking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, xemul@parallels.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org
Cc: criu@openvz.org
Date: Sat, 17 Oct 2015 18:54:50 +0530
In-Reply-To: <87a8rhit61.fsf@linux.vnet.ibm.com>
References: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
 <b1ae177b872e901b01a4071c92c4db23a3323be3.1444995096.git.ldufour@linux.vnet.ibm.com>
 <87a8rhit61.fsf@linux.vnet.ibm.com>
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

On Sat, 2015-10-17 at 17:49 +0530, Aneesh Kumar K.V wrote:
> This will break after
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135298.html
> 
> 
> A good option is to drop this patch from the series and let Andrew take
> the first two patches. You can send an updated version of patch 3 against
> linux-powerpc tree once Michael pulls that series to his tree. 

Or not ... I'm not comfortable with your series just yet for the reasons
I mentioned earlier (basically doubling the memory footprint of the page
tables).

They are already too big.

Cheers,
Ben.
