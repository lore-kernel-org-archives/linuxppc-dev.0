Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40JD803vK5zF1vy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 20:58:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
 linux-nvdimm@lists.01.org
Subject: Re: [PATCH v3 3/4] doc/devicetree: Persistent memory region bindings
In-Reply-To: <20180406052116.31483-3-oohall@gmail.com>
References: <20180406052116.31483-1-oohall@gmail.com>
 <20180406052116.31483-3-oohall@gmail.com>
Date: Sat, 07 Apr 2018 20:58:37 +1000
Message-ID: <87zi2fb7vm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:
> Add device-tree binding documentation for the nvdimm region driver.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> v2: Changed name from nvdimm-region to pmem-region.
>     Cleaned up the example binding and fixed the overlapping regions.
>     Added support for multiple regions in a single reg.
> v3: Removed platform bus boilerplate from the example.
>     Changed description of the volatile and reg properties
>     to make them more clear.

Thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
