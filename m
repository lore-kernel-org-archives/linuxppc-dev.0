Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08078B7BBA
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Dec 2009 12:04:47 +1100 (EST)
Subject: Re: using different format for hugetlbfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5034AAE3-CCF9-446D-AC4B-B3F59C81D507@kernel.crashing.org>
References: <230774E3-2D94-44DA-85AC-151485996789@kernel.crashing.org>
	<1259917136.2076.1264.camel@pasglop>
	<90D0766D-30A2-4ABE-9707-C7F64A697BFE@kernel.crashing.org>
	<1259961942.2076.1277.camel@pasglop>
	<5034AAE3-CCF9-446D-AC4B-B3F59C81D507@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Dec 2009 12:04:37 +1100
Message-ID: <1260147877.2076.1346.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> 
> Even than, does that preclude the format I suggested?  I'm assuming  
> that pgd_t/pud_t/pmd_t are always a double word so the low order 4- 
> bits should be 0 (on 64-bit), so using the lsb as the flag between  
> hugetlb and normal pointer should still work.

Might do, depends if David has enough bits ...  David ?

Cheers,
Ben.
