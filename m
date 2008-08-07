Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E82FDDF78
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 08:51:28 +1000 (EST)
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0808060946v39992095pfb6b85726b7d307d@mail.gmail.com>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<ed82fe3e0808060946v39992095pfb6b85726b7d307d@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 08 Aug 2008 08:36:15 +1000
Message-Id: <1218148575.24157.313.camel@pasglop>
Mime-Version: 1.0
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-06 at 11:46 -0500, Timur Tabi wrote:
> On Wed, Aug 6, 2008 at 1:02 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > of_lookup_stdout() is useful for figuring out what device to use as output
> > for early boot progress messages.  It returns the node pointed to by the
> > linux,stdout-path property in the chosen node.
> 
> I thought linux,stdout-path is deprecated are we're supposed to be
> using the aliases node instead?

You are mixing two completely different things afaik.

Ben.
