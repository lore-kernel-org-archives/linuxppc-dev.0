Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 58125DDEF7
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 04:56:00 +1100 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080228001053.404893334@ldl.fc.hp.com>
References: <20080228001053.404893334@ldl.fc.hp.com>
	<20080228000437.880811124@ldl.fc.hp.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 6/6] PCI: consolidate several pcibios_enable_resources()
	implementations
Date: Thu, 28 Feb 2008 17:55:33 +0000
Message-ID: <7005.1204221333@redhat.com>
Sender: dhowells@redhat.com
Cc: Chris Zankel <chris@zankel.net>, Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> 
>     frv: checks only 6 resources at (1), has a different ROM
> 	resource check at (4) and (6) that ignores IORESOURCE_ROM_ENABLE
> ...
>     mn10300: checks only 6 resources at (1), has no IORESOURCE_{IO,MEM}
> 	check at (3), has a different ROM resource check at (4) and (6)
> 	that ignores IORESOURCE_ROM_ENABLE

Both parts:

Acked-by: David Howells <dhowells@redhat.com>
