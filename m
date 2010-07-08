Return-Path: <lawrence@softsystem.co.uk>
Received: from smtp23.services.sfr.fr (smtp23.services.sfr.fr [93.17.128.20])
	by ozlabs.org (Postfix) with ESMTP id D2788B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 19:01:13 +1000 (EST)
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2308.sfr.fr (SMTP Server) with ESMTP id 55A0A700009F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 11:01:11 +0200 (CEST)
Received: from smtp-in.softsystem.co.uk (118.117.200-77.rev.gaoland.net
	[77.200.117.118])
	by msfrf2308.sfr.fr (SMTP Server) with SMTP id 0BAF870000A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 11:01:10 +0200 (CEST)
Received: FROM [192.168.1.62] (gagarin [192.168.1.62])
	BY smtp-in.softsystem.co.uk [77.200.117.118] (SoftMail 1.0.5,
	www.softsystem.co.uk) WITH ESMTP
	FOR <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jul 2010 11:01:07 +0200
Subject: Re: [PATCH] Add cmd64x IDE driver to default pmac32 config
From: lawrence rust <lawrence@softsystem.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1278570620.28659.79.camel@pasglop>
References: <1278181316.3232.45.camel@gagarin>
	<1278565221.28659.74.camel@pasglop> <1278569907.1411.19.camel@gagarin>
	<1278570620.28659.79.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 11:01:07 +0200
Message-ID: <1278579667.2850.5.camel@gagarin>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-08 at 16:30 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2010-07-08 at 08:18 +0200, lawrence rust wrote:
> > 
> > Sure. it would be preferable but unfortunately the PowerMac on-board IDE
> > controller (CONFIG_BLK_DEV_IDE_PMAC), used for the DVD drive on B/W
> > G3's, doesn't have a PATA equivalent.  So it's pragmatic (until the IDE
> > code is removed) to use the IDE cmd64x driver to minimise kernel code
> > size.
> 
> Sure it does nowadays: drivers/ata/pata_macio.c :-)
> 
> I merged that upstream in december last year, so it didn't make 2.6.32
> which your distro probably uses, but it is in .33 and later.

OK I see that - good news.  However, for the moment I believe that it's
safer to stay with IDE.  It's the smallest of changes but the wholesale
move to libata could well break numerous system install scripts - e.g.
for yaboot.

-- Lawrence
