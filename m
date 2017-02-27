Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWyCY6fT2zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:11:05 +1100 (AEDT)
In-Reply-To: <1487639538-25922-1-git-send-email-mdroth@linux.vnet.ibm.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: powerpc/pseries: advertise Hot Plug Event support to firmware
Message-Id: <3vWyCY60M9z9sNC@ozlabs.org>
Date: Mon, 27 Feb 2017 21:11:05 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-21 at 01:12:18 UTC, Michael Roth wrote:
> With the inclusion of:
> 
>   powerpc/pseries: Implement indexed-count hotplug memory remove
>   powerpc/pseries: Implement indexed-count hotplug memory add
> 
> we now have complete handling of the RTAS hotplug event format
> as described by PAPR via ACR "PAPR Changes for Hotplug RTAS Events".
> 
> This capability is indicated by byte 6, bit 5 of architecture
> option vector 5, and allows for greater control over cpu/memory/pci
> hot plug/unplug operations.
> 
> Existing pseries kernels will utilize this capability based on the
> existence of the /event-sources/hot-plug-events DT property, so we
> only need to advertise it via CAS and do not need a corresponding
> FW_FEATURE_* value to test for.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3dbbaf200f532e01e56168b8339f29

cheers
