Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4179DDF08
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 05:08:02 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBBI9g4o004137
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 13:09:42 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBBI7wgT1306740
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 13:07:58 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBBI7mrF030521
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:07:48 -0700
Date: Tue, 11 Dec 2007 12:07:33 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Patches added to for-2.6.25 and master branches of powerpc.git
Message-ID: <20071211120733.70e03125@weaponx>
In-Reply-To: <18270.8249.393061.840667@cargo.ozlabs.ibm.com>
References: <18270.8249.393061.840667@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 11 Dec 2007 16:29:29 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Benjamin Herrenschmidt (7):
>       [POWERPC] Make isa_mem_base common to 32 and 64 bits
>       [POWERPC] Merge pci_process_bridge_OF_ranges()
>       [POWERPC] Fix powerpc 32-bit resource fixup for 64-bit resources
>       [POWERPC] Change 32-bit PCI message about resource allocation
>       [POWERPC] Remove useless volatiles in udbg_16550.c
>       [POWERPC] Add of_translate_dma_address
>       [POWERPC] Early debug forces console log level to max

Excellent.  I have a series of patches that I'll be sending your way
shortly after Ben sends out a fixed up 4xx PCI series.  Have a few
commits from Valentine and Stefan in there as well.

josh
