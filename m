Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C653FDF1A5
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 06:07:04 +1000 (EST)
Subject: Re: [RFC v3 PATCH 1/4] Extract list of relocation offsets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mohan@in.ibm.com
In-Reply-To: <20080717184055.GB25070@in.ibm.com>
References: <20080717183339.GA25070@in.ibm.com>
	<20080717184055.GB25070@in.ibm.com>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 06:06:27 +1000
Message-Id: <1216325187.7740.353.camel@pasglop>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus@samba.org, miltonm@bga.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-18 at 00:10 +0530, Mohan Kumar M wrote:
> Extract list of relocation offsets
> 
> Extract list of offsets in the vmlinux file for which the relocation
> delta has to be patched. Currently only following type of relocation
> types are considered: R_PPC64_ADDR16_HI, R_PPC64_TOC and R_PPC64_ADDR64
> 
> The offsets are sorted according to the relocation type and this
> information is appended to the normal vmlinux file by using the patch
> relocation_build.patch

Please, provide an indication of what changed since the previous
version of the patch to make the reviewer's life easier !

Thanks,
Ben.
