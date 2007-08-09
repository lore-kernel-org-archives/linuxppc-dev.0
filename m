Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id A8C27DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 11:04:49 +1000 (EST)
Date: Wed, 8 Aug 2007 20:04:32 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] remove gratuitous reads from maple pci config space
	methods
Message-ID: <20070809010431.GF10114@localdomain>
References: <20070809005044.GD10114@localdomain>
	<1186620933.938.211.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186620933.938.211.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2007-08-08 at 19:50 -0500, Nathan Lynch wrote:
> > 
> > Remove the gratuitous reads from u3_agp_write_config,
> > u3_ht_write_config, and u4_pcie_write_config.
> > 
> > Signed-off-by: Nathan Lynch <ntl@pobox.com>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Thanks ! Care to fix powermac too ? :-)

Sure, I'll get it tomorrow... looks like pasemi cribbed the powermac
code too :)
