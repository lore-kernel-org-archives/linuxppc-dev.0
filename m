Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 58DDC68785
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 18:01:35 +1100 (EST)
Message-ID: <43798741.5070604@compulab.co.il>
Date: Tue, 15 Nov 2005 08:59:13 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Hans Schillstrom <hans.schillstrom@pwav.com>
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>	
	<200510120859.12362.sr@denx.de>	<434CB71E.5000603@compulab.co.il>	
	<200510120927.56692.sr@denx.de>	
	<20051012133414.7f7e2faf.ajz@cambridgebroadband.com>	
	<4365BD71.9010507@compulab.co.il>
	<1131960060.7748.9.camel@hawk.pwav.net>
In-Reply-To: <1131960060.7748.9.camel@hawk.pwav.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8555 USB host support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hans Schillstrom wrote:

>Hi Mike
>I'm working with a 8270 board and 2.6.12 kernel and searching for USB
>drivers.
>
>Could you help me finding the files ?
>  
>
I've opened a project on the SourceForge, 
http://cpm2usb.sourceforge.net. The file containing patch against 
2.6.12.3 can be downloaded at http://sourceforge.net/projects/cpm2usb.

>I can help you with the testing.
>What status do they have right now ?
>  
>
The driver was developed on MPC8272ADS, but should go as well on 8270 
since they have the same USB host controller AFAIK.
Currently, as far as I tested it works fine with full-speed single 
device attached through hub, but fails is there are transfers from/to 
several devices simultaneously.
As for the code itself, it's far from being perfect.

>Regards 
>Hans
>  
>


-- 
Sincerely yours,
Mike Rapoport
