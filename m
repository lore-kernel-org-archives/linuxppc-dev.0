Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whp7l52yzzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 20:38:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 1/2] powerpc/numa: Update CPU topology when VPHN enabled
In-Reply-To: <82db34cc-7bb4-00cd-a8c8-ef1143e09d02@linux.vnet.ibm.com>
References: <201706041107.Ri5JRxir%fengguang.wu@intel.com>
 <82db34cc-7bb4-00cd-a8c8-ef1143e09d02@linux.vnet.ibm.com>
Date: Tue, 06 Jun 2017 20:38:42 +1000
Message-ID: <87tw3tpfil.fsf@concordia.ellerman.id.au>
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

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> This build appears to be using V3 of the patch.  V4 of the patch corrected the placement
> of the local variables with respect to '#ifdef CONFIG_PPC_SPLPAR'.

Yes it is, you can tell because it's a reply to "PATCH V3".

cheers
