Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 85734DDF46
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 22:46:07 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 02 Oct 2007 14:46:06 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <470165F6.7030505@freescale.com>
Message-ID: <20071002124606.242690@gmx.net>
MIME-Version: 1.0
References: <20071001210025.314240@gmx.net> <470165F6.7030505@freescale.com>
Subject: Re: Problem with OF interrupt parsing code
To: Scott Wood <scottwood@freescale.com>
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
> Datum: Mon, 01 Oct 2007 16:26:14 -0500
> Von: Scott Wood <scottwood@freescale.com>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: Problem with OF interrupt parsing code

> > Secondly the AmigaOne is a desktop system with 4 PCI/AGP slots,
> > thus I can't specify device nodes for all possible devices. By looking
> > at pci_read_irq_line() in pci_common.c it should be possible for the
> > kernel to fall back to the interrupt settings in the PCI config space
> > of every device.
> 
> Those interrupt settings are purely a communication vector from firmware 
> to OS.  Is your firmware putting i8259 interrupt numbers in there, and 
> did you set the default interrupt controller?
Yes, the firmware puts the i8259 interrupt numbers in the PCI interrupt
line register and the PIC is setup as default interrupt controller.

Gerhard

-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
