Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5771A2BDB5
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Nov 2004 09:14:13 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20041119110609.GA2924@iram.es>
References: <1100847411.25521.42.camel@gaston> <20041119110609.GA2924@iram.es>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 09:14:00 +1100
Message-Id: <1100902440.3856.21.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2004-11-19 at 12:06 +0100, Gabriel Paubert wrote:
> On Fri, Nov 19, 2004 at 05:56:50PM +1100, Benjamin Herrenschmidt wrote:
> > NOTE: Owners of _OTHER_ Apple laptops that could already sleep, like
> > earlier iBooks, or Titanium PowerBooks, please test this patch as well
> > for regression. More specifically, test if sleep still works, X/DRI, and
> > backlight control as I have made significant changes to radeonfb in ways
> > that could affect those areas.
> 
> Everytime my Pismo wakes up I have the following:
> 
> Badness in enable_irq at kernel/irq/manage.c:106

 .../...

Yah, it's known, and harmless, just didn't find the time to fix it yet,
thanks for the patch. It's due to a change in the main OHCI code which
nowadaws frees and re-requests the interrupt on sleep.

Ben.
