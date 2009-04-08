Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id DEAA2DDFBA
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 02:01:43 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: AMCC 440EP phy detection
Date: Wed, 8 Apr 2009 18:01:27 +0200
References: <49DB8033.1090908@embeddedarm.com>
	<49DBEB8F.2040307@embeddedarm.com>
	<49DCC6FA.1050708@embeddedarm.com>
In-Reply-To: <49DCC6FA.1050708@embeddedarm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904081801.27754.sr@denx.de>
Cc: Eddie Dawydiuk <eddie@embeddedarm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 08 April 2009, Eddie Dawydiuk wrote:
> > I found the ibm_newemac driver(2.6.29) makes the assumption that the
> > bootloader has already configured the tx enable pin as it is a
> > multiplexed pin. Unfortuantley I am not using U-Boot and our minimal
> > bootloader does not do this.  After finding tx enable was never
> > asserting for Eth0 a quick user space program verified tx enable was
> > configured as a GPIO pin.
>
> I would like to eventually submit our changes for upstream support. Based
> on this would you recommend ensuring tx enable is configured properly in
> the initialization of the ibm_newemac driver or the platform
> initialization?

This GPIO multiplexing configuration does not belong into the ibm_newemac 
driver since it is very platform/board specific. The platform code is 
definitely a better place.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
