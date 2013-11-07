Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4F2672C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 15:56:00 +1100 (EST)
Message-ID: <1383800148.4776.164.camel@pasglop>
Subject: Re: [PATCH 4/7] IBM Akebono: Add support to the OHCI platform
 driver for Akebono
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alistair Popple <alistair@popple.id.au>
Date: Thu, 07 Nov 2013 15:55:48 +1100
In-Reply-To: <1462812.9fJW2bi87G@mexican>
References: <Pine.LNX.4.44L0.1311051002131.1360-100000@iolanthe.rowland.org>
 <1462812.9fJW2bi87G@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-11-07 at 14:34 +1100, Alistair Popple wrote:
> Thanks. Based on the discussion for the EHCI driver I would like to change the 
> compatibility string to "usb-ochi" (instead of "ibm,akebono-ohci"). Are you 
> still happy for me to add the Acked-by with the alternate compatibility (and 
> of course the formatting fix)? No other drivers currently use "usb-ochi" so it 
> shouldn't require any merging of drivers.

	s/ochi/ohci/ :-)

Cheers,
Ben.
