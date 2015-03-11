Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 13A251A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 19:21:21 +1100 (AEDT)
Message-ID: <1426062062.17565.22.camel@kernel.crashing.org>
Subject: Re: [PATCH SLOF] pci-properties: Remove redundant call to device-type
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Huth <thuth@linux.vnet.ibm.com>
Date: Wed, 11 Mar 2015 19:21:02 +1100
In-Reply-To: <20150311085030.43ac4fac@oc7435384737.ibm.com>
References: <1426055192-28691-1-git-send-email-aik@ozlabs.ru>
 <20150311085030.43ac4fac@oc7435384737.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-11 at 08:50 +0100, Thomas Huth wrote:
> 
> - Graphic cards should get the "display" device_type ... I guess
> that's
>   missing now?

At least the code for qemu-vga does it

> - pci bus nodes (like bridges) should get the "pci" device_type
>   according to the Open Firmware PCI binding, is this still the case?

Ah yes we need to check that, specifically P2P bridges

> - Seems like there are some other devices with device_type property
>   where SLOF does not provide an implemented interface, like in
>   slof/fs/usb/dev-mouse.fs ... should these be revised, too?

not a *huge* issue but we can look into it when needed.

Cheers,
Ben.
