Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DFBB767A80
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2005 19:26:42 +1100 (EST)
Date: Thu, 10 Mar 2005 00:26:39 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050310082639.GA19275@gate.ebshome.net>
References: <d5ec5d6983bd5bb2276f3d73c49edc3e@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d5ec5d6983bd5bb2276f3d73c49edc3e@freescale.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: build failure for 2.6.11-mm2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 10, 2005 at 02:10:04AM -0600, Kumar Gala wrote:
> Do you have any ideas on what changes occurred in the makefiles to 
> cause the uImage related failures:
> 
> http://l4x.org/k/?d=2173

This looks like mkimage is just not present on build host. I don't 
think it's included anywhere in kernel tree, so it must be installed 
separately.

--
Eugene
