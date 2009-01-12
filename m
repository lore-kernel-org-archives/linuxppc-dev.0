Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4BBF5DE0A2
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 16:15:08 +1100 (EST)
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40901070841o3ede1d56tf5f69c33523513f4@mail.gmail.com>
References: <20090107135457.234150@gmx.net> <20090107140132.140980@gmx.net>
	<fa686aa40901070841o3ede1d56tf5f69c33523513f4@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Jan 2009 16:07:30 +1100
Message-Id: <1231736850.22571.17.camel@pasglop>
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

On Wed, 2009-01-07 at 09:41 -0700, Grant Likely wrote:
> For the flattened device tree, I think we've settled on the convention
> that every node with an IRQ connection should have both the
> interrupt-parent and interrupts properties.  (ie. don't rely on the
> parent node's interrupt-parent property.)

Ah ? I use the trick of relying on the parent node regulary :-) Where
did we discuss that ?

Ben.
