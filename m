Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0EBE3DDE19
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 12:11:20 +1100 (EST)
Date: Wed, 5 Dec 2007 04:11:11 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: John Tyner <jtyner@cs.ucr.edu>
Subject: Re: [PATCH] Make QSpan PCI work
Message-ID: <20071205041111.4c1f466f@kernel.crashing.org>
In-Reply-To: <20071203210500.GB22557@cs.ucr.edu>
References: <20071203210500.GB22557@cs.ucr.edu>
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

On Mon, 3 Dec 2007 13:05:00 -0800
John Tyner wrote:

> The following patch makes the QSpan PCI code compile and work on my 
> hardware. The patch is against 2.4, but I'm hoping it will still be
> viewed as useful since the code currently does not even compile (2.6
> is the same). I had to make a change to move the PCI setup later in
> the m8xx_setup code as well because the kernel would crash during the 
> pcibios_alloc_controller because the bootmem stuff had not come up
> yet.
> 
This looks interesting, but again would make a lot of sense for powerpc and 2.6.
Is that possible to have your patches rebased against 2.6, arch/ppc at least?

-- 
Sincerely, Vitaly
