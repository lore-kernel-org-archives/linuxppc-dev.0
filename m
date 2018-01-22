Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqp57bFzF0XH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:14 +1100 (AEDT)
In-Reply-To: <1d7f84eb-defc-a1ae-fd8b-d4c00a16aedb@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: nfont@linux.vnet.ibm.com, Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Re: [V6,
 1/4] powerpc/firmware: Add definitions for new drc-info firmware
 feature
Message-Id: <3zPxqp1y4wz9sNc@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-01 at 23:19:40 UTC, Michael Bringmann wrote:
> Firmware Features: Define new bit flag representing the presence of
> new device tree property "ibm,drc-info".  The flag is used to tell
> the front end processor whether the Linux kernel supports the new
> property, and by the front end processor to tell the Linux kernel
> that the new property is present in the device tree.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3f38000eda485f466153d37c4f9201

cheers
