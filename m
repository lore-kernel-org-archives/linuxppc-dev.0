Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85ABE680F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 20:55:05 +1000 (EST)
Message-ID: <4333DF04.3000908@iki.fi>
Date: Fri, 23 Sep 2005 12:55:00 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:

>There is a bug in the SMC init code, wher the base address for the SMC's
>is not reinitialized by the kernel, so if the SMC is not initialized by
>the bootloader, it will not work.
>
>If that is the case, try this patch.
>  
>
The SMC was previously initialised, but I still upgraded to 2.6.14-rc2, 
which includes your patch. It still doesn't work, the buffer descriptor 
must be at a wrong address somehow since the board just hangs now in the 
same routine.

I did manage to decode the message coming to the console with the two 
leds onboard... it begun with "Linux ve", which at least looks like a 
good boot-up message :)
