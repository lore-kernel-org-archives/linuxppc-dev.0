Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id B6AF1DDFDC
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 04:19:22 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: AMCC 440EP phy detection
Date: Wed, 8 Apr 2009 20:19:06 +0200
References: <49DB8033.1090908@embeddedarm.com> <200904081801.27754.sr@denx.de>
	<fa686aa40904081000x2dbdd417y149fe442b9fc55bf@mail.gmail.com>
In-Reply-To: <fa686aa40904081000x2dbdd417y149fe442b9fc55bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904082019.06889.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Eddie Dawydiuk <eddie@embeddedarm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 08 April 2009, Grant Likely wrote:
> >> I would like to eventually submit our changes for upstream support.
> >> Based on this would you recommend ensuring tx enable is configured
> >> properly in the initialization of the ibm_newemac driver or the platform
> >> initialization?
> >
> > This GPIO multiplexing configuration does not belong into the ibm_newemac
> > driver since it is very platform/board specific. The platform code is
> > definitely a better place.
>
> Even better is the platform specific boot code (firmware or equivalent)

Ack. We usually do all this setup in U-Boot. But as I understand Eddie, he is 
using a custom bootloader.

Eddie, btw: Why are you not using U-Boot?

Best regards,
Stefan
