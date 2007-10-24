Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id B604EDDE2F
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 05:13:26 +1000 (EST)
Date: Wed, 24 Oct 2007 21:12:06 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/2] mpc52xx: stop drivers from accessing clock config
	directly
Message-ID: <20071024191206.GD3369@nd47.coderock.org>
References: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 24/10/07 12:24 -0600, Grant Likely wrote:
> Domen,
> 
> Here's a real solution to the problem.  I've somewhat tested this on
> the lite5200b.  Can you give it a spin on efika and see if SPI still
> works for you?

My test case was lite5200b too, I don't think I ever tried SPI on
efika.
(Are even the right pins on irda connector, or is a necessary line
missing?)


	Domen

> 
> Thanks,
> g.
> 
> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.

-- 
Domen Puncer | Research & Development
.............................................................................................
Telargo d.o.o. | Zagrebška cesta 20 | 2000 Maribor | Slovenia
.............................................................................................
www.telargo.com
