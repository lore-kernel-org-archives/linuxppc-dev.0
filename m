Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 18622DDFF7
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 03:00:47 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so123369ywe.39
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Apr 2009 10:00:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200904081801.27754.sr@denx.de>
References: <49DB8033.1090908@embeddedarm.com>
	<49DBEB8F.2040307@embeddedarm.com>
	<49DCC6FA.1050708@embeddedarm.com> <200904081801.27754.sr@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 8 Apr 2009 10:00:30 -0700
Message-ID: <fa686aa40904081000x2dbdd417y149fe442b9fc55bf@mail.gmail.com>
Subject: Re: AMCC 440EP phy detection
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Eddie Dawydiuk <eddie@embeddedarm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 8, 2009 at 9:01 AM, Stefan Roese <sr@denx.de> wrote:
> On Wednesday 08 April 2009, Eddie Dawydiuk wrote:
>> > I found the ibm_newemac driver(2.6.29) makes the assumption that the
>> > bootloader has already configured the tx enable pin as it is a
>> > multiplexed pin. Unfortuantley I am not using U-Boot and our minimal
>> > bootloader does not do this. =A0After finding tx enable was never
>> > asserting for Eth0 a quick user space program verified tx enable was
>> > configured as a GPIO pin.
>>
>> I would like to eventually submit our changes for upstream support. Base=
d
>> on this would you recommend ensuring tx enable is configured properly in
>> the initialization of the ibm_newemac driver or the platform
>> initialization?
>
> This GPIO multiplexing configuration does not belong into the ibm_newemac
> driver since it is very platform/board specific. The platform code is
> definitely a better place.

Even better is the platform specific boot code (firmware or equivalent)

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
