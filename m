Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D570DDF59
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 07:42:01 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: Cleanup 32/64 bit syscall int sign ext.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080925185219.GB5230@ld0162-tx32.am.freescale.net>
References: <1222326096.8277.178.camel@pasglop>
	<20080925185219.GB5230@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Fri, 26 Sep 2008 07:41:49 +1000
Message-Id: <1222378909.8277.200.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-09-25 at 13:52 -0500, Scott Wood wrote:
> On Thu, Sep 25, 2008 at 05:01:36PM +1000, Benjamin Herrenschmidt wrote:
> > +#define XGLUE(a,b) a##b
> > +#define GLUE(a,b) XGLUE(a,b)
> 
> GLUE() doesn't appear to be used.

Yup, obsolete remains from an earlier variant.

Ben.
