Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 6B4A0DDFA4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 20:17:14 +1000 (EST)
Message-ID: <48C79F12.5040503@coritel.it>
Date: Wed, 10 Sep 2008 12:18:58 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: skepper@ukf.net
Subject: Re: Not probing devices on PowerPC MPC8247 and kernel 2.6.26
References: <Pine.LNX.4.62.0809101058580.24139@chara.vm.bytemark.co.uk>
In-Reply-To: <Pine.LNX.4.62.0809101058580.24139@chara.vm.bytemark.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Chris,

probably there's some mismatch between the device (for example some 
information in dts) and the driver. The match function scan for a driver 
for those devices but the values compared don't match the values of the 
drivers.

Regards.

Chris Skepper ha scritto:
> Hi All,
>
> I have an MPC8247 based board. I can get the SMC1 console working, but 
> the other SCCx serial ports and the FCC1 ethernet doesn't work.
>
> It appears that a part of the problem is that the probe methods are 
> not called. The "match" table stuff all looks fine and the serial 
> ports and ethernet are defined in the .dts file. The module init 
> function is called, but the probe methods are not reached. It seems 
> driver_register gets called, so why doesn't something call probe?
>
> Is there likely to be some problem with the bus setup?
>
> Cheers,
>
> Chris.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
