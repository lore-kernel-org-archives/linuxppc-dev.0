Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 04A18B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 01:55:37 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 341B1DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 01:55:35 +1000 (EST)
Message-Id: <883C2E2A-F904-4FDE-9363-BF813B90676D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090723055951.7867DDDD1B@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 4/20] powerpc/mm: Add opcode definitions for tlbivax and
	tlbsrx.
Date: Thu, 23 Jul 2009 10:55:26 -0500
References: <20090723055951.7867DDDD1B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 23, 2009, at 12:59 AM, Benjamin Herrenschmidt wrote:

> This adds the opcode definitions to ppc-opcode.h for the two  
> instructions
> tlbivax and tlbsrx. as defined by Book3E 2.06
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> arch/powerpc/include/asm/ppc-opcode.h |    6 ++++++
> 1 file changed, 6 insertions(+)

Do we really have binutils that don't have tlbivax properly at this  
point?

- k
