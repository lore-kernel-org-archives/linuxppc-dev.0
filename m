Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 5ECE4DDEDF
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 08:11:24 +1100 (EST)
Date: Wed, 3 Jan 2007 15:11:17 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] maple: improve CPC9x5 host bridge detection
Message-ID: <20070103211117.GF6279@localdomain>
References: <20070103185628.GE6279@localdomain>
	<1167857446.6165.155.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1167857446.6165.155.camel@localhost.localdomain>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2007-01-03 at 12:56 -0600, Nathan Lynch wrote:
> > Identify CPC9x5 PCI Express, AGP, and HT host bridges using
> > device_type and compatible properties, which is a more flexible method
> > than using the name property (which can differ between firmwares and
> > models).
> > 
> > Signed-off-by: Nathan Lynch <ntl@pobox.com>
> 
> Do that work on js20/js21 with SLOF ?

Not sure, I'll see whether I can test one of those.
