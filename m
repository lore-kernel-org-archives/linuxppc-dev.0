Return-Path: <leitao@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp02.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 057D7B7D57
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 00:35:32 +1100 (EST)
Received: from mailhub3.br.ibm.com (mailhub3.br.ibm.com [9.18.232.110])
	by e24smtp02.br.ibm.com (8.14.3/8.13.1) with ESMTP id o11Din4K007361
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2010 11:44:49 -0200
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o11Dbpb82224166
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2010 11:37:51 -0200
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o11DZKkf023982
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2010 11:35:20 -0200
Message-ID: <4B66D894.3060604@linux.vnet.ibm.com>
Date: Mon, 01 Feb 2010 11:35:16 -0200
From: Breno Leitao <leitao@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/pci: Add calls to set_pcie_port_type() and
	set_pcie_hotplug_bridge()
References: <1264561803.3601.163.camel@pasglop>
In-Reply-To: <1264561803.3601.163.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben, 

Benjamin Herrenschmidt wrote: 
> Breno, can you test ? Also if you could give a quick spin to the other ones
> too make sure they don't break anything else, it would be great ! 
I tested and also asked my team to test and the changes work fine, fixing
the problem. Also, we did a regression test and nothing seem to be broken.

Thanks, 
Breno
