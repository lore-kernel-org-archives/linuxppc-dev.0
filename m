Return-Path: <leitao@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp04.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26C8CB7CE2
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Feb 2010 03:43:15 +1100 (EST)
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by e24smtp04.br.ibm.com (8.14.3/8.13.1) with ESMTP id o1JGV9KF025505
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 14:31:09 -0200
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1JGhAhG4055170
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 13:43:10 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1JGh96d020132
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 14:43:10 -0200
Message-ID: <4B7EBF9A.7020801@linux.vnet.ibm.com>
Date: Fri, 19 Feb 2010 14:43:06 -0200
From: Breno Leitao <leitao@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] eeh: Fixing a bug when pci structure is null
References: <1264789719-15591-1-git-send-email-leitao@linux.vnet.ibm.com>
	<4B6864F4.1030106@linux.vnet.ibm.com>	<20100202180503.GL4757@pengutronix.de>
	<4B699CB9.3030605@linux.vnet.ibm.com>
In-Reply-To: <4B699CB9.3030605@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Linas Vepstas <linasvepstas@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben, 

I'd like to ask about this patch ? Should I re-submit ?

Thanks, 

Breno Leitao wrote:
> During a EEH recover, the pci_dev structure can be null, mainly if an
> eeh event is detected during cpi config operation. In this case, the
> pci_dev will not be known (and will be null) the kernel will crash
> with the following message:
