Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7Hd3bcLzF0XK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:30:05 +1100 (AEDT)
In-Reply-To: <151214686823.64022.14062853099614941612.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V3, 8/9] powerpc/drmem: Add support for ibm,
 dynamic-memory-v2 property
Message-Id: <3zM7Hc6l95z9sRm@ozlabs.org>
Date: Thu, 18 Jan 2018 00:30:02 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-01 at 16:47:53 UTC, Nathan Fontenot wrote:
> The Power Hypervisor has introduced a new device tree format for
> the property describing the dynamic reconfiguration LMBs for a system,
> ibm,dynamic-memory-v2. This new format condenses the size of the
> property, especially on large memory systems, by reporting sets
> of LMBs that have the same properties (flags and associativity array
> index).
> 
> This patch updates the powerpc/mm/drmem.c code to provide routines
> that can parse the new device tree format during the walk_drmem_lmb*
> routines used during boot, the creation of the LMB array, and updating
> the device tree to create a new property in the proper format for
> ibm,dynamic-memory-v2.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2b31e3aec1dbaae5f0a6f0e485fcb1

cheers
