Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5059467C38
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 08:36:54 +1000 (EST)
Subject: Re: [PATCH 1/5] powerpc: consolidate feature fixup code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061013115457.7b36a7c3@localhost.localdomain>
References: <1160726663.4792.222.camel@localhost.localdomain>
	<20061013115457.7b36a7c3@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 14 Oct 2006 08:36:46 +1000
Message-Id: <1160779006.4792.269.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You can advance the pointer with L1_CACHE_BYTES/sizeof(int) per
> iteration in the second loop here.

Yeah, I suppose so. Though I'm not 100% confident we get L1_CACHE_BYTES
on all cpus, for example, PA6T is 64 bytes ;) We could use
cur_cpu_spec->icache_bsize but that would involve ugly RELOC's to get it
right on 32 bits. I decided not to care for now.

Ben.
