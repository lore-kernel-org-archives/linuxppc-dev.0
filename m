Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDA9EDDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Nov 2007 18:37:16 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Iuk93-00048t-Rw
	for linuxppc-embedded@ozlabs.org; Tue, 20 Nov 2007 23:37:13 -0800
Message-ID: <13872475.post@talk.nabble.com>
Date: Tue, 20 Nov 2007 23:37:13 -0800 (PST)
From: Lorenz Kolb <linuxppcemb@lkmail.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ML403 USB driver
In-Reply-To: <fa686aa40711200731n61d239fdw4ac1d64a95ad97ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13858912.post@talk.nabble.com>
	<fa686aa40711200731n61d239fdw4ac1d64a95ad97ff@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




Grant Likely-2 wrote:
> 
> On 11/20/07, Lorenz Kolb <linuxppcemb@lkmail.de> wrote:
> 
>>
>> Anyway, only one of the two peripheral ports seems to be active.
> 
> Yes, I've got that problem here too.  I haven't yet solved it.  Any
> help would be appreciated.
> 
> Cheers,
> g.
> 
> 

Well that's what we have found out till now, maybe it helps, or at least
what we think to have found out:
- First of all to the non functioning peripheral port:
It is "USB Peripheral 1".
According to the schematics it should be powered using the OTGVBus-Port of
the Cypress-Controller (nevertheless it has currently no level)

- Secondly there is no configuration 1 Host + 2 Peripherals according to the
datasheet from Cypress
- Thirdly the initial configuration (at least that is what we are guessing)
seems to be done via some standalone program coming from an Eeprom.
- The three pins near the UART port are the serial console for the Cypress
chip (we have not yet done any tests with that).
- At least the peripherals are connected in a right way, as one SIE can only
have one peripheral


Some question aside the peripheral topic:
Has anyone any idea how to make the cypress chip to have a _normal_ Host not
an OTG one (as some USB-Hub might save us from our dilemma why we tried to
use gadgets in peripheral mode)?

Regards,

Lorenz Kolb
-- 
View this message in context: http://www.nabble.com/ML403-USB-driver-tf4844098.html#a13872475
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
