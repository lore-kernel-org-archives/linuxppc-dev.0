Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57E23DDF22
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 02:38:34 +1000 (EST)
In-Reply-To: <470BAAA2.30400@freescale.com>
References: <1191945199488-git-send-email-timur@freescale.com>
	<B8D11E08-7AC5-4B21-9C40-1068B29B058B@kernel.crashing.org>
	<470BA5DF.5060206@freescale.com>
	<2E830F97-ADAE-43CA-9BD3-BEBFEFBE1D5C@kernel.crashing.org>
	<470BAAA2.30400@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8D4AA8EB-812F-4E58-A13C-CE3BA72037F3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe: add function qe_clock_source
Date: Tue, 9 Oct 2007 11:38:48 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, I went and looked at how rx-clock & tx-clock are spec'd in  
booting-without-of.txt

Why dont we fix this so we have a property that says "BRG" or "CLK"  
and another that has ID = [1.16] for BRG and [1..24] for CLK.

- k
