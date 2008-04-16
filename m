Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09C47DE13A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 22:31:24 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3GCVLrI013376
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:31:21 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3GCVKET247736
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:31:20 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3GCVK26017643
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:31:20 -0400
Date: Wed, 16 Apr 2008 07:27:58 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Re: Please pull 'for-2.6.26' branch of 4xx tree
Message-ID: <20080416072758.092c83c5@zod.rchland.ibm.com>
In-Reply-To: <20080415102704.39511160@zod.rchland.ibm.com>
References: <20080415102704.39511160@zod.rchland.ibm.com>
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

On Tue, 15 Apr 2008 10:27:04 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> Valentine Barshak (2):
>       [POWERPC] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
>       [POWERPC] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock workaround

These two commits have been dropped from the branch.  They cause the
allyesconfig build for powerpc to fail because CONFIG_PPC_DCR_MMIO
doesn't understand the dcri_clrset macro.

josh
