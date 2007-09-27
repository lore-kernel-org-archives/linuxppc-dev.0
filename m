Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 5DF2DDDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 05:31:33 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 27 Sep 2007 21:31:31 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20070927192551.GK7970@austin.ibm.com>
Message-ID: <20070927193131.201920@gmx.net>
MIME-Version: 1.0
References: <20070927191233.201980@gmx.net>
	<20070927192551.GK7970@austin.ibm.com>
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
> Datum: Thu, 27 Sep 2007 14:25:51 -0500
> Von: linas@austin.ibm.com
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: 2.6.23-rc8 dies somewhere during boot!?

> On Thu, Sep 27, 2007 at 09:12:33PM +0200, Gerhard Pircher wrote:
> > Hi,
> > 
> > I'm working on a 2.6.23 kernel for the AmigaOne.
> 
> [...]
> 
> > <6>PCI: Probing PCI hardware.
> > <7>PCI: Scanning bus 0...
> > ...00:00:07.0.
> > <7>PCI: Calling quirk...
> > ...CI: Found 0000:00:07.2 [1106/303...
> 
> 
> Any chance that this thing has an e100 ethernet card in it? 
> If so, edit drivers/pci/quirks.c and ifdef out the readb()
> in the e100_quirk routine.
No, it has a 3Com 3c905C/3c920 10/100Mbit controller.

Gerhard

-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
