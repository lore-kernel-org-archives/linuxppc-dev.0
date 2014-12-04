Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D92D91A09E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:40:35 +1100 (AEDT)
In-Reply-To: <1417663477-9124-1-git-send-email-weiyang@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/pci: remove pci device on a bus in reverse order
Message-Id: <20141204054035.C3DAC1400E9@ozlabs.org>
Date: Thu,  4 Dec 2014 16:40:35 +1100 (AEDT)
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-04-12 at 03:24:37 UTC, Wei Yang wrote:
> As in commit ac205b7b (PCI: make sriov work with hotplug remove) indicates,
> when removing pci devices on a bus which has VFs, we need to remove them in
> the reverse order.
> 
> This patch applies this pattern on the hotplug remove path on powerpc arch.

So is this is a bug fix?

Where/how have you tested this?

cheers
