Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4868167D56
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 16:46:38 +1100 (EST)
Received: from az33smr01 (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	kAE5kadD019742
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 22:46:36 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01 (8.13.1/8.13.0) with ESMTP id kAE5kQN4012442
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 23:46:30 -0600 (CST)
Subject: Re: [PATCH 7/32] powerpc: Make pci_read_irq_line the default
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20061110074452.BBF6167D13@ozlabs.org>
References: <20061110074452.BBF6167D13@ozlabs.org>
Content-Type: text/plain
Message-Id: <1163483230.3906.2.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 14 Nov 2006 13:47:10 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-10 at 15:44, Benjamin Herrenschmidt wrote:

> I also haven't updated the old-style fixup code from 85xx_cds.c
> because it's actually buggy :) It assigns pci_dev->irq hard coded
> numbers which is no good with the new IRQ mapping code. It should
> at least use irq_create_mapping(NULL, hard_coded_number); and possibly
> also set_irq_type() to set them as level low.
> 
85xx cds is a little more complex. There are hardware revises.
Hope to fix it soon :-).
Roy 
