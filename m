Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 51141DDE2F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 15:43:44 +1000 (EST)
Date: Wed, 19 Sep 2007 07:11:57 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Message-ID: <20070919051157.GH32628@nd47.coderock.org>
References: <20070711093113.GE4375@moe.telargo.com>
	<20070711093220.GF4375@moe.telargo.com>
	<20070806065857.GN4529@moe.telargo.com>
	<18160.39896.132391.625791@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18160.39896.132391.625791@cargo.ozlabs.ibm.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 19/09/07 13:47 +1000, Paul Mackerras wrote:
> Domen Puncer writes:
> 
> > Paul, what do you say about this?
> > Sylvain suggested it could also be integrated with define_machine
> > interface.
> 
> As it stands, your patch adds the clk_* functions on all platforms.
> What platforms would actually want to use them?

52xx
Reason for adding it to all was that EXPORT_SYMBOL's would clash if
one were to add clk support for another platform.


	Domen

> 
> Paul.
