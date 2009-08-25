Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1E8D7B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 11:08:34 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F0CADDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 11:08:33 +1000 (EST)
Subject: Re: [PATCH 1/5] powerpc/mm: Add MMU features for TLB reservation &
	Paired MAS registers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <8951DD4A-6F85-4E24-A55C-2E8759E14DF7@kernel.crashing.org>
References: <1250658513-13009-1-git-send-email-galak@kernel.crashing.org>
	<1250666756.4810.16.camel@pasglop>
	<AC207041-6DB9-476E-B171-C1F6E10D3FAB@kernel.crashing.org>
	<1250729028.4810.42.camel@pasglop>
	<8951DD4A-6F85-4E24-A55C-2E8759E14DF7@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 25 Aug 2009 11:08:25 +1000
Message-Id: <1251162505.15197.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-24 at 11:12 -0500, Kumar Gala wrote:
> Duh.  Wasn't looking at the fall through.
> 
> But is there any reason to even have any of the 6 instructions in
> the  
> 'virt_page_table_tlb_miss_done' path if we don't have TLBSRX?
> 
No, that's what I said in my initial email :-) You can probably
"alternate out" that whole thing.

Cheers,
Ben.
