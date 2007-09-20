Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18162.1.982956.610996@cargo.ozlabs.ibm.com>
Date: Thu, 20 Sep 2007 15:07:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
In-Reply-To: <20070919051157.GH32628@nd47.coderock.org>
References: <20070711093113.GE4375@moe.telargo.com>
	<20070711093220.GF4375@moe.telargo.com>
	<20070806065857.GN4529@moe.telargo.com>
	<18160.39896.132391.625791@cargo.ozlabs.ibm.com>
	<20070919051157.GH32628@nd47.coderock.org>
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

Domen Puncer writes:

> 52xx
> Reason for adding it to all was that EXPORT_SYMBOL's would clash if
> one were to add clk support for another platform.

What I meant was, why aren't you using a config symbol so that we
don't build it on platforms that don't need any "clk" support at all?

Paul.
