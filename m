Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24C821A08B4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 17:09:27 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 2 Feb 2015 01:09:25 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CA54138C8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 01:09:21 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1269Lvd26542122
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 06:09:21 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1269Lwi024936
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 01:09:21 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH V3] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
In-Reply-To: <20150202050821.24581.56186.stgit@preeti.in.ibm.com>
References: <20150202050821.24581.56186.stgit@preeti.in.ibm.com>
Date: Mon, 02 Feb 2015 17:09:17 +1100
Message-ID: <m3fvaou9o2.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Preeti U Murthy <preeti@linux.vnet.ibm.com> writes:
> The device tree now exposes the residency values for different idle states. Read
> these values instead of calculating residency from the latency values. The values
> exposed in the DT are validated for optimal power efficiency. However to maintain
> compatibility with the older firmware code which does not expose residency
> values, use default values as a fallback mechanism. While at it, use better
> APIs to parse the powermgmt device tree node so as to avoid endianness
> transformation.
>
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Same acked-by as before, from perspective of "I merged the firmware side
of things" and things look godo in relation to firmware PoV.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
