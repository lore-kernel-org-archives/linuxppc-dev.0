Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTpd014SzDr0t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:57:28 +1000 (AEST)
Message-ID: <1466470648.9938.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Auto online hotplugged memory
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 21 Jun 2016 10:57:28 +1000
In-Reply-To: <5767F4D0.7070504@linux.vnet.ibm.com>
References: <5767F4D0.7070504@linux.vnet.ibm.com>
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

On Mon, 2016-06-20 at 08:51 -0500, Nathan Fontenot wrote:

> Auto online hotplugged memory
> 
> A recent update (commit id 31bc3858ea3) to the core mm hotplug code
> introduced the memhp_auto_online variable to allow for automatically
> onlining memory that is added.
> 
> This patch update the pseries memory hotplug code to enable this so that
> any memory DLPAR added to the system is automatically onlined. The code
> to add the memory block for memory added from add_memory() is removed as
> this is not needed, the memory_add code does this.

Is this a bug fix, or just a cleanup?

cheers
