Return-Path: <markc@mail.com>
Received: from relay02.roc.ny.frontiernet.net (relay02.roc.ny.frontiernet.net
	[66.133.182.165]) by ozlabs.org (Postfix) with ESMTP id 8FD2367BC2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jul 2005 00:14:39 +1000 (EST)
Message-ID: <004001c57e47$5cae9410$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Dan Malek" <dan@embeddededge.com>,
	"Clemens Koller" <clemens.koller@anagramm.de>
References: <42C40BD0.8040408@anagramm.de><658739DB-540F-4AFC-80DC-BBF0C2AD70F4@freescale.com><42C4162E.4030602@anagramm.de><427c70958bb995dad4fbad2e6ff121bc@embeddededge.com><42C4F50D.3050405@anagramm.de>
	<d946affc11510f7116710026d2a8d1f3@embeddededge.com>
Date: Fri, 1 Jul 2005 10:15:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx DMA support for Kernel 2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> 
> On Jul 1, 2005, at 3:47 AM, Clemens Koller wrote:
> 
> > .... And currently, when I access (memcopy) the SRAM on my
> > Local Bus via UPM I cannot get it to generate bursts yet, so I hope the
> > DMA will speed up those things, too.
> 
> If the CPU won't do it, the DMA won't either.  You better get that
> UPM working first :-)
> 
> 
> -- Dan
> 

Is the SRAM being cached?  I don't think the CPU will generate bursts
unless it's cached, right?

Mark Chambers
