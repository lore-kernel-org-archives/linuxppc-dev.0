Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58491B7E08
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Feb 2010 08:55:24 +1100 (EST)
Subject: Re: [PATCH] eeh: Fixing a bug when pci structure is null
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linasvepstas@gmail.com
In-Reply-To: <3ae3aa421002190905l67e9f235he9537aeb0e56790e@mail.gmail.com>
References: <1264789719-15591-1-git-send-email-leitao@linux.vnet.ibm.com>
	<4B6864F4.1030106@linux.vnet.ibm.com>
	<20100202180503.GL4757@pengutronix.de>
	<4B699CB9.3030605@linux.vnet.ibm.com>
	<4B7EBF9A.7020801@linux.vnet.ibm.com>
	<3ae3aa421002190905l67e9f235he9537aeb0e56790e@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 20 Feb 2010 08:55:06 +1100
Message-ID: <1266616506.23523.1027.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-19 at 11:05 -0600, Linas Vepstas wrote:
> 
> Some confusion -- I've been out of the loop for a while -- I assume
> its still Paul who is pushing
> these patches upstream, and not Ben?  So Breno, maybe you should
> resend the patch to Paul? 

No, it's me.

Cheers,
Ben.
