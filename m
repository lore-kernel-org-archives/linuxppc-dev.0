Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 89B59DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 07:57:37 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 27 Sep 2007 23:57:35 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20070927213503.GA18686@austin.ibm.com>
Message-ID: <20070927215735.201960@gmx.net>
MIME-Version: 1.0
References: <20070927191233.201980@gmx.net>
	<20070927192551.GK7970@austin.ibm.com> <20070927193131.201920@gmx.net>
	<20070927205012.GN7970@austin.ibm.com> <20070927211700.201970@gmx.net>
	<20070927213503.GA18686@austin.ibm.com>
Subject: Re: 2.6.23-rc8 dies somewhere during boot!?
To: linas@austin.ibm.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Thu, 27 Sep 2007 16:35:03 -0500
> Von: linas@austin.ibm.com
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: 2.6.23-rc8 dies somewhere during boot!?

> On Thu, Sep 27, 2007 at 11:17:00PM +0200, Gerhard Pircher wrote:
> > > Betreff: Re: 2.6.23-rc8 dies somewhere during boot!?
> > 
> > Do you have an idea how to debug it?
> 
> Not particularly. What caught my eye was the failure right near the
> PCI quirk stuff, as I was having problems there as well (but apearntly,
> for very different reasons).
Yes, I also suspect the PCI code. The AmigaOne has a VIA southbridge.
AFAIK there were some changes in the PCI quirks for VIA chipsets, but so
far I couldn't see any significant changes in the code.

> Based on your boot messages, it looks like you are failing somewhere in
> pci probe.  My olde-fashioned, slow, but-usually-works method is to
> sprinkle enough printk's into the code to catch it in the act.
I guess the code in arch/powerpc/pci*.c is the right place to sprinkle
some printk's into the code?

Gerhard
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
