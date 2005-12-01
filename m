Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 1FAA86886F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 00:58:19 +1100 (EST)
Message-ID: <438F00DE.5020004@compulab.co.il>
Date: Thu, 01 Dec 2005 15:55:42 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Hans Schillstrom <hans.schillstrom@pwav.com>
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>	
	<200510120859.12362.sr@denx.de>	<434CB71E.5000603@compulab.co.il>	
	<200510120927.56692.sr@denx.de>	
	<20051012133414.7f7e2faf.ajz@cambridgebroadband.com>	
	<4365BD71.9010507@compulab.co.il>
	<1131960060.7748.9.camel@hawk.pwav.net>	
	<43798741.5070604@compulab.co.il>
	<1133439981.8518.237.camel@hawk.pwav.net>
In-Reply-To: <1133439981.8518.237.camel@hawk.pwav.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8555 8280/8270 USB host support
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
>I've made some modifications due to the difference between mpc8272 and
>mpc8270. MPC8272 use SCC3 and MPC8270 use SCC4.
>Added some more clock configuration options ...
>  
>
Thanks a lot.
I've added your patch as is to the SF page.

>
>Don't you think u-boot should take care of clock setup
>i.e. as much as possible of all board dependent stuff ?
>  
>
I think you're right, but then it was easier to make all these setups in 
the driver itself.

>
>Regards 
>Hans Schillstrom
>
>  
>

-- 
Sincerely yours,
Mike Rapoport
