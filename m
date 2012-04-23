Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DC573B6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 06:40:27 +1000 (EST)
Message-ID: <1335213619.21619.25.camel@pasglop>
Subject: RE: pci node question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yoder Stuart-B08248 <B08248@freescale.com>
Date: Tue, 24 Apr 2012 06:40:19 +1000
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E1503347AB5@039-SN1MPN1-002.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
 <1334956286.3197.16.camel@pasglop>
 <9F6FE96B71CF29479FF1CDC8046E150334747D@039-SN1MPN1-002.039d.mgd.msft.net>
 <1335212491.21619.23.camel@pasglop>
 <9F6FE96B71CF29479FF1CDC8046E1503347AB5@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-23 at 20:32 +0000, Yoder Stuart-B08248 wrote:
>   /* config space address of the device 0,0,0. OF convention is that
>      the size of config space is 0. */
> 
> ...is that accurate? 

Dunno about OF convention here, but it's what I've seen done. In any
case, anything with a PCI device in the .dts will have that, I don't
know whether that's worth putting such a large comment in every .dts
around...

Cheers,
Ben.
