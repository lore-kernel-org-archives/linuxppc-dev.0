Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Remove unused lexer function 
In-reply-to: <20080729045136.GD19856@yookeroo.seuss> 
References: <20080729045136.GD19856@yookeroo.seuss>
Date: Thu, 31 Jul 2008 10:39:38 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KOaFe-0006MY-3j@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> dtc does not use the input() function in flex.  Apparently on some gcc
> versions the unused function will cause warnings.  Therefore, this
> patch removes the function by using the 'noinput' option to flex.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
