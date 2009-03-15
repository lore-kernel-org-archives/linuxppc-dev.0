Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ECE00DDFDE
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 10:57:04 +1100 (EST)
Subject: Re: use generic	pci_assign_unassign_resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Takatz <takatz@pericle.com>
In-Reply-To: <49BAE147.4060102@pericle.com>
References: %(message_id_url)s  <49BAE147.4060102@pericle.com>
Content-Type: text/plain
Date: Mon, 16 Mar 2009 10:56:54 +1100
Message-Id: <1237161414.25062.105.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-03-13 at 16:42 -0600, Mark Takatz wrote:
> Ben,
> 
> We're looking at the fixes you put in place for the various PCI errors 
> and we think this is the solution we need for our system, a GE Fanuc CM6 
> PPC board (single 8641), but your patches appear to apply either to 
> 2.6.24 or 2.6.25, and we have 2.6.23.  Do you know of any similar work 
> done on the 2.6.23 release?
> 
> Thanks in advance for any help you can provide,

No, you would have to backport major chunks of the PCI rework I did in
between, along with fixes I did after that. At this stage I would
recommend considering an update to 2.6.27 or 2.6.28.

Cheers,
Ben.
