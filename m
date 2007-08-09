Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9BAC3DDE18
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 05:47:25 +1000 (EST)
Date: Thu, 9 Aug 2007 15:03:27 -0500
From: Olof Johansson <olof@lixom.net>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [RFC/PATCH] remove gratuitous reads from maple pci config
	space methods
Message-ID: <20070809200327.GB14344@lixom.net>
References: <20070809005044.GD10114@localdomain>
	<1186620933.938.211.camel@localhost.localdomain>
	<20070809010431.GF10114@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070809010431.GF10114@localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 08, 2007 at 08:04:32PM -0500, Nathan Lynch wrote:
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

Yeah, it originated either from powermac or maple so it's there too. Feel
free to fix it too while you're at it.


-Olof
