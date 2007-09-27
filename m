Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C3D33DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 08:27:34 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 28 Sep 2007 00:27:33 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20070927222007.GE18686@austin.ibm.com>
Message-ID: <20070927222733.201970@gmx.net>
MIME-Version: 1.0
References: <20070927191233.201980@gmx.net>
	<20070927192551.GK7970@austin.ibm.com> <20070927193131.201920@gmx.net>
	<20070927205012.GN7970@austin.ibm.com> <20070927211700.201970@gmx.net>
	<20070927213503.GA18686@austin.ibm.com> <20070927215735.201960@gmx.net>
	<20070927222007.GE18686@austin.ibm.com>
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
> Datum: Thu, 27 Sep 2007 17:20:07 -0500
> Von: linas@austin.ibm.com
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: 2.6.23-rc8 dies somewhere during boot!?

> On Thu, Sep 27, 2007 at 11:57:35PM +0200, Gerhard Pircher wrote:
> 
> The last identifiable message I was
> 
> <7>PCI: Calling quirk...
> 
> which is from drivers/pci/quirks.c
> 
> ...CI: Found 0000:00:07.2 [1106/303...
> 
> and this is from pci_setup_device() in drivers/pci/probe.c  So I'd look
> to see if pci_setup_device() ever returned, and then I'd look to see
> what happened next.
Ah, I thought probing is done in the architecture's PCI code. I'll take
a look at pci_setup_device() function.

Thanks!

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
