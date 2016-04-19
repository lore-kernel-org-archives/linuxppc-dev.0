Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpllf2gBLzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 10:10:38 +1000 (AEST)
Message-ID: <1461024638.22587.1.camel@ellerman.id.au>
Subject: Re: [RFC v4] powerpc/devtree: Parse new DRC mem/cpu/dev device tree
 elements
From: Michael Ellerman <mpe@ellerman.id.au>
To: mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, mbringm@us.ibm.com
Date: Tue, 19 Apr 2016 10:10:38 +1000
In-Reply-To: <201604181438.u3IEcmG7023884@oc1376853207.ibm.com>
References: <201604181438.u3IEcmG7023884@oc1376853207.ibm.com>
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

On Mon, 2016-04-18 at 09:38 -0500, mwb@linux.vnet.ibm.com wrote:

> Several properties in the DRC device tree format are replaced by
> more compact representations to allow, for example, for the encoding
> of vast amounts of memory, and or reduced duplication of information
> in related data structures.
> 
> "ibm,drc-info": This property, when present, replaces the following
> four properties: ibm,drc-indexes, ibm,drc-names, ibm,drc-types
> and ibm,drc-power-domains.  This property is defined for all
> dynamically reconfigurable platform nodes.  The "ibm,drc-info" elements
> are intended to provide a more compact representation, and reduce some
> search overhead.
> 
> "ibm,dynamic-memory-v2": This property replaces the "ibm,dynamic-memory"
> node representation within the "ibm,dynamic-reconfiguration-memory"
> property.  This element format is intended to provide a more compact
> representation of memory, especially, for systems with massive amounts
> of RAM.
> 
> "ibm,architecture.vec": Bit flags are added to this data structure
> by the front end processor to inform the kernel as to whether to expect
> the changes to one or both of the device tree structures "ibm,drc-info"
> and "ibm,dynamic-memory-v2".
> 
> The new element structures, "ibm,dynamic-memory-v2" and "ibm,drc-info",
> should completely replace the previously used structures at execution.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---

What's changed in version 2, 3 and 4?

I also sent you comments on v2, did you see them?

cheers
