Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D66ADE0E6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 02:26:16 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m69GQC6H016301
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 12:26:12 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m69GQCmf182680
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 12:26:12 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m69GQCYa031468
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 12:26:12 -0400
Date: Wed, 9 Jul 2008 12:22:49 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2] powerpc: Fix problems with 32bit PPC's running with
	>= 4GB of RAM
Message-ID: <20080709122249.12311920@zod.rchland.ibm.com>
In-Reply-To: <1215616163-20803-1-git-send-email-sr@denx.de>
References: <1215616163-20803-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed,  9 Jul 2008 17:09:23 +0200
Stefan Roese <sr@denx.de> wrote:

> This patch enables 32bit PPC's (with 36bit physical address space, e.g.
> IBM/AMCC PPC44x) to run with >= 4GB of RAM. Mostly its just replacing types
> (unsigned long -> phys_addr_t).
> 
> Tested on an AMCC Katmai with 4GB of DDR2.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

Thanks :).  FWIW, I was just going to fixup the commit log manually,
but a new patch works too.

josh
