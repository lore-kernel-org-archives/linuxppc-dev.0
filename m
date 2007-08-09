Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2134EDDDDB
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 11:15:04 +1000 (EST)
Subject: Re: [RFC/PATCH] remove gratuitous reads from maple pci config
	space methods
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20070809010431.GF10114@localdomain>
References: <20070809005044.GD10114@localdomain>
	<1186620933.938.211.camel@localhost.localdomain>
	<20070809010431.GF10114@localdomain>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 11:14:57 +1000
Message-Id: <1186622097.938.213.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-08 at 20:04 -0500, Nathan Lynch wrote:
> Benjamin Herrenschmidt wrote:
> > On Wed, 2007-08-08 at 19:50 -0500, Nathan Lynch wrote:
> > > 
> > > Remove the gratuitous reads from u3_agp_write_config,
> > > u3_ht_write_config, and u4_pcie_write_config.
> > > 
> > > Signed-off-by: Nathan Lynch <ntl@pobox.com>
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > Thanks ! Care to fix powermac too ? :-)
> 
> Sure, I'll get it tomorrow... looks like pasemi cribbed the powermac
> code too :)

Allright, thanks !

Cheersm
Ben.
