Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] fsl/embedded6xx: don't cast the result of
	of_get_property
Date: Wed, 26 Sep 2007 10:52:23 +1000
References: <1189748800.165136.731062325870.1.gpush@pokey>
	<1189748800.165997.810365539433.2.gpush@pokey>
	<20070926104419.1b92002e.sfr@canb.auug.org.au>
In-Reply-To: <20070926104419.1b92002e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200709261052.25044.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen,

> If you don't use the value of the len variable, then you can pass
> NULL to of_get_property.

Sure, but that's probably a separate patch, no ?

> Not *phys_addr?

That's what the existing code does. I'm guessing that it treats 
phys_addr as an array with one entry, not a single u32.

Cheers,


Jeremy
