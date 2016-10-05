Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzv5BcRzDrLw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:27 +1100 (AEDT)
In-Reply-To: <1475128325-5367-7-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [v4,
 6/7] drivers/pci/hotplug: Use of_property_read_u32() in powernv driver
Message-Id: <3spfzv2q2qz9sfH@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-29-09 at 05:52:04 UTC, Gavin Shan wrote:
> This replaces of_get_property() with of_property_read_u32() or
> of_property_read_string() so that we needn't consider the endian
> issue, the returned value always is in CPU-endian.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/39f0d6fbdc3f205d0c61a9c530c682

cheers
