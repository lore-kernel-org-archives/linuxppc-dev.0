Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0EC5167B97
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 21:43:55 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.6/8.13.6) with ESMTP id k68Bhoia160264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Jul 2006 11:43:51 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k68Bkd9E084852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Jul 2006 13:46:39 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k68Bhn0B026892
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Jul 2006 13:43:50 +0200
Date: Sat, 8 Jul 2006 13:42:01 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/6] Sizing zones and holes in an architecture independent
	manner V8
Message-ID: <20060708114201.GA9419@osiris.boeblingen.de.ibm.com>
References: <20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
Cc: akpm@osdl.org, davej@codemonkey.org.uk, tony.luck@intel.com,
	linux-mm@kvack.org, ak@suse.de, bob.picco@hp.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 08, 2006 at 12:10:42PM +0100, Mel Gorman wrote:
> There are differences in the zone sizes for x86_64 as the arch-specific code
> for x86_64 accounts the kernel image and the starting mem_maps as memory
> holes but the architecture-independent code accounts the memory as present.

Shouldn't this be the same for all architectures? Or to put it in other words:
why does only x86_64 account the kernel image as memory hole?
