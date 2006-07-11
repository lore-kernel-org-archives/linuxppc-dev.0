Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3A9F67B55
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 09:02:26 +1000 (EST)
Subject: Re: Maple platform - adding graphics to IBM PIBS firmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jf simon <jfaslist@yahoo.fr>
In-Reply-To: <44B3A772.3000101@yahoo.fr>
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DE5E@ismail.innsys.innovsys.com>
	<20060710214158.1d8dcf2c@vitb.ru.mvista.com>
	<Pine.LNX.4.60.0607102135330.10561@poirot.grange>
	<1152567817.1576.114.camel@localhost.localdomain>
	<44B3A772.3000101@yahoo.fr>
Content-Type: text/plain; charset=utf-8
Date: Wed, 12 Jul 2006 09:02:17 +1000
Message-Id: <1152658938.6346.76.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-07-11 at 15:28 +0200, jf simon wrote:
> Hi,
> We have designed a VME CPU card based on IBM Maple platform.
> We've had problems making it work with a PCI/PMC graphic card we've also 
> designed based around the ATI Radeon 7000 (RV100 QY). To solve this we 
> have linux consultants helping us in emulating the ATI video BIOS at the 
> linux kernel level.
> But we would like to modify  the PIBs firmware with simple routines 
> (scroll,..)  to use the graphic screen attached to the ATI as a text 
> (alphanumeric) console. The keyboard would be USB.
> Is this possible even if the video BIOs didn't previously  initialize 
> the ATI graphic chip?

If the BIOS hasn't initialized the chip, you are pretty much out of
luck... The good news is that soft-booting an rv100 with the BIOS works
fine, at least from my previous experiemnts with it.

> I realize this question doesn't re
> ally belong here...but not sure where 
> to ask, sorry about that.
> Thanks a lot
> -jf simon
> 
> 
> 
> 
> 
> 
> 	
> 
> 	
> 		
> ___________________________________________________________________________ 
> Yahoo! Mail réinvente le mail ! Découvrez le nouveau Yahoo! Mail et son interface révolutionnaire.
> http://fr.mail.yahoo.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
