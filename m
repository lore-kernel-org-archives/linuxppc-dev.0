Return-Path: <flucifredi@acm.org>
Received: from mail27.sea5.speakeasy.net (mail27.sea5.speakeasy.net
	[69.17.117.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9307467A95
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 10:40:08 +1100 (EST)
Received: from blhealthcare.com (HELO [192.168.1.201])
	(federico@[151.204.230.210]) (envelope-sender <flucifredi@acm.org>)
	by mail27.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA
	encrypted SMTP
	for <linuxppc-embedded@ozlabs.org>; 26 Jan 2005 23:33:26 -0000
Message-ID: <41F8281C.3040202@acm.org>
Date: Wed, 26 Jan 2005 18:30:36 -0500
From: Federico Lucifredi <flucifredi@acm.org>
MIME-Version: 1.0
Cc: "Linux-ppc [mailing list]" <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: MPC8272ADS and frame buffer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Bora,
 

> FL>     It turns out you can solve your problem by using the Epson 
> SD13806
> FL> evaluation board (s5u13806b00c).
>
> Has this evaboard got PCI interface?
>  
>
It is a PCI card form factor. The epson chip does NOT have a PCI 
interface on board, so a PCI bridge chip is there to support PCI 
operation -- In short, if you want to use PCI, it is available by 
activating it with a DIP switch.  I did use it, and it works.

> FL> It comes with drivers distributed, FL> inanely enough, as a patch 
> for a specific kernel, so prepare for some FL> hand-patching. Other 
> than that, it works.
>  
>

> We would like to use it with two purposes. One is to display 
> browser(Opera, Mozilla, Firefox or what
> it is) and second one is to play films encoded by mpeg. AFAIK, this 
> card is framebuffer style. It
> has some 2D acceleration mainly for blitting operations. I think films 
> are not drawing thing. Color
> space conversion, scaling are discussed. But others are drawing thing.
>
> Do you think this card is enought for them?
>  
>
I believe the card is enough for browser operation, yes. I am not sure 
about playing video beacuse I have not performance-checked it , and as 
you pointed out, it is unaccelerated.  It should be able to display 
whatever you throw at it though, so if you can do the MPEG decoding 
completely in software on the MPC side, you should be fine.

Do you work at Turk Telecom or are you just a customer ? What is your 
project, if I may ask ?

   -Federico

-- 
_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish

Muad'Dib of Caladan (Federico L. Lucifredi)- Harvard University & BU
http://metcs.bu.edu/~lucifred
