Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1116ADDDFD
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 17:43:50 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 03 Oct 2007 09:43:47 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1191362607.22572.26.camel@pasglop>
Message-ID: <20071003074347.242670@gmx.net>
MIME-Version: 1.0
References: <20071001210025.314240@gmx.net> <20071001211120.156280@gmx.net>	
	<d3eb2341d21ed1f9f7e71f097878731f@kernel.crashing.org>	
	<1191279244.6310.32.camel@pasglop>  <20071002123849.242670@gmx.net>
	<1191362607.22572.26.camel@pasglop>
Subject: Re: Problem with OF interrupt parsing code
To: benh@kernel.crashing.org
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
> Datum: Wed, 03 Oct 2007 08:03:27 +1000
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: Problem with OF interrupt parsing code

> 
> On Tue, 2007-10-02 at 14:38 +0200, Gerhard Pircher wrote:
> > I know that it's ugly, but the problem is how to distinguish the
> > boards. The only real difference I know of is the PCI interrupt
> > mapping. The northbridges chip revision for example is always the
> > same, but CPU type, amount of memory and PCI devices can appear in
> > all possible combinations. The firmware doesn't tell me, which board
> > the kernel is runnning on, so I would like to rely on this fall back
> > here until I get the chance to update the firmware (which is beyond
> > my control).
> 
> And how does the firmware know ? There must be a strap somewhere...
> 
> Ben.
Good question. I don't know. Anyway I changed the device tree based on
your comments and now it works (at least until the kernel deadlocks
somewhere else). :(

Gerhard

-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
