Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E4A4DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 07:56:19 +1000 (EST)
Subject: Re: [PATCH 1/2] Add sysdev/pci_quirks.c file into PowerPC
	architecture with ULI chip quirk functions.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <11859560694083-git-send-email-wei.zhang@freescale.com>
References: <11859560681182-git-send-email-wei.zhang@freescale.com>
	<11859560694083-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 07:56:00 +1000
Message-Id: <1186005360.5495.529.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-01 at 16:14 +0800, Zhang Wei wrote:
> Add sysdev/pci_quirks.c file into PowerPC architecture with
> ULI chip quirk functions.
> We add generic quirk functions for ULI chips
> from individual platform into arch/powerpc/sysdev/pci_quirks.c file.
> 

Are we sure that any powerpc machine that uses that ULI chip will need
the same quirk setting ?

Ben.
