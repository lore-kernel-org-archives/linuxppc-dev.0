Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37314B7113
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 10:01:30 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p19IgM7l020787
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 13:43:20 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B580E728128
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 18:00:57 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p19Mxd792003012
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 17:59:40 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p19MxdpE029127
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 20:59:39 -0200
Subject: Re: [PATCH V2 3/6] powerpc/47x: allow kernel to be loaded in
	higher physical memory
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7637207D-0D0C-4920-9E8D-B175711C1164@kernel.crashing.org>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-4-git-send-email-shaggy@linux.vnet.ibm.com>
	<7637207D-0D0C-4920-9E8D-B175711C1164@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 09 Feb 2011 16:59:38 -0600
Message-ID: <1297292378.14457.3.camel@shaggy-w500>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-02-02 at 01:45 -0600, Kumar Gala wrote:
> On Feb 1, 2011, at 12:48 PM, Dave Kleikamp wrote:
> 
> > Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > ---
> > arch/powerpc/Kconfig                          |    2 +-
> > arch/powerpc/configs/44x/iss476-smp_defconfig |    6 ++--
> > arch/powerpc/kernel/head_44x.S                |   42 ++++++++++++++++++++-----
> > arch/powerpc/mm/44x_mmu.c                     |   13 ++++++--
> > 4 files changed, 48 insertions(+), 15 deletions(-)
> 
> Would be nice to expand in the commit message on what "higher physical" means.

right.  should be clear in the next set

-- 
Dave Kleikamp
IBM Linux Technology Center
