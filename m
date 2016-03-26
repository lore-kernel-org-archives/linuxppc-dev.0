Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXF970zRCzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 20:23:55 +1100 (AEDT)
In-Reply-To: <1458921821-14960-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, zhlcindy@linux.vnet.ibm.com
Subject: Re: [RFC] powerpc/mm: Support bootmem for PPC64 again
Message-Id: <3qXF961KWTz9s4x@ozlabs.org>
Date: Sat, 26 Mar 2016 20:23:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-25-03 at 16:03:41 UTC, Gavin Shan wrote:
> CONFIG_NO_BOOTMEM is enabled on PPC platforms by default. However,
> user might disable that to have bootmem for other purpose. So it's
> resonable to support it.

Hi Gavin,

Sorry but I don't understand. We deliberately removed bootmem support, and don't
want it back, it doesn't add anything other than complexity. See 10239733ee86
("powerpc: Remove bootmem allocator").

I wasn't aware there was any way to enable it? If there is we should fix that.

cheers
