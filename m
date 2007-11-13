Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0A503DDE20
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 19:05:43 +1100 (EST)
Date: Tue, 13 Nov 2007 02:06:31 -0600
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] [POWERPC] consolidate struct pci_controller
Message-ID: <20071113080631.GA17756@lixom.net>
References: <20071113163427.2ab3fdb0.sfr@canb.auug.org.au>
	<20071113163707.cfefe98a.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071113163707.cfefe98a.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 13, 2007 at 04:37:07PM +1100, Stephen Rothwell wrote:

> This one clashes slightly with Benh's "Merge pci_process_bridge_OF_ranges()"
> patch.

Hi Stephen,

For the small fields that use standard types, you should just be able
to still define them for ppc32 and just not use them. Alternatively,
if the 32-bit guys complain about wasted bytes of memory, bunch up the
ppc64-only fields together for a single ifdef.


-Olof
