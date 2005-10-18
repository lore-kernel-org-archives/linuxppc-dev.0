Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 178E7685C2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 05:41:25 +1000 (EST)
In-Reply-To: <20051018142411.GA14065@logos.cnet>
References: <434BC424.50700@ru.mvista.com> <20051018142411.GA14065@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4c41159c3c06e288e5d69469f1e3ce7b@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 18 Oct 2005 15:46:55 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: ppc_sys fixes for 8xx and 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 18, 2005, at 10:24 AM, Marcelo Tosatti wrote:

> For 8xx, I was wondering if the PARTNUM field of the IMMR
> (section 10.4.1 of MPC860UM.pdf) does have meaningful
> information which could be used to identify the CPU.

It has meaningful information, but not the way you want
to use it :-)  The PARTNUM/MASKNUM is only useful
once you know the type of processor (like 823, 850, 885, etc)
The PARTNUM is only useful within the "family."  For
example, the 860 and 880 are two different families, and
will contain the similar PARTNUM values through their life.
I believe it's tied to the fabrication process.

You may as well stop looking for an easy (or possibly
any) way to differentiate these parts in software, but
due to they way they are fabricated, I don't think that's
ever going to happen. :-)


	-- Dan
