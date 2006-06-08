Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9248767A0E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 10:26:14 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix cell blade detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3EB64128-691F-4DB9-922E-C60CE739168F@kernel.crashing.org>
References: <1149645858.27572.93.camel@localhost.localdomain>
	<3EB64128-691F-4DB9-922E-C60CE739168F@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 10:26:02 +1000
Message-Id: <1149726362.23790.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-08 at 01:09 +0200, Segher Boessenkool wrote:
> > +#ifdef CONFIG_PPC64
> > +			/* We must make sure we don't detect the IBM Cell
> > +			 * blades as pSeries due to some firmware issues,
> > +			 * so we do it here.
> > +			 */
> 
> Is this #ifdef needed?  Do we really care about 22 bytes of rodata?

For 32 bits platforms, yes :)

Ben.
