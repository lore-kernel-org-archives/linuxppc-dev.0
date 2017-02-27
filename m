Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWyCW2CfmzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:11:03 +1100 (AEDT)
In-Reply-To: <1486474844-9872-1-git-send-email-dougmill@linux.vnet.ibm.com>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/1] powerpc/xmon: Dump memory in native endian format.
Message-Id: <3vWyCW0cY6z9sN5@ozlabs.org>
Date: Mon, 27 Feb 2017 21:11:02 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-07 at 13:40:44 UTC, Douglas Miller wrote:
> Extend dump command to allow display of 2, 4, and 8 byte words in native
> endian format. Also adds dump command for "1 byte words" for the sake
> of symmetry. New commands are:
> 
> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5e48dc0aa4d9daf93e9bff2a274473

cheers
