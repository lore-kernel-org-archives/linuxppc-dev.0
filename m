Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Use noinput flex option for convert-dtsv0 to remove warning 
In-reply-to: <20081107004548.GH6692@yookeroo.seuss> 
References: <20081107004548.GH6692@yookeroo.seuss>
Date: Mon, 17 Nov 2008 14:09:15 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1L2APL-0003fD-Gp@jdl.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The convert-dtsv0 lexer doesn't use lex's input() macro/function.
> This can result in "defined but not used" warnings.  This patch uses
> flex's noinput option to prevent this warning (as we already do for
> dtc-lexer.l).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
