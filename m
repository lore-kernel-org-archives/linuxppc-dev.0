Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 2E79D6851C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 17:30:37 +1000 (EST)
Message-ID: <434CB71E.5000603@compulab.co.il>
Date: Wed, 12 Oct 2005 09:11:26 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>	<200510101900.58976.sr@denx.de>	<61cc712d0510111329i45138617lc8eeea1edad4ae0f@mail.gmail.com>
	<200510120859.12362.sr@denx.de>
In-Reply-To: <200510120859.12362.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
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

Stefan Roese wrote:

>Pantelis, you mentioned an existing (and working ;-)) linux 2.4 USB HCI driver 
>for 8xx and 82xx. Did you find the time to clean the driver up? Perhaps, I 
>could be your "vict^H^H^Holunteer", to port it to 2.6.
>

Stefan,
I don't know if Pantelis found a volo^H^H^Hictim, but I've made some 
porting of the USB HCI driver for
82xx (I afraid 8xx support was broken during the port). But the code is 
*very* ugly and still buggy.

-- 
Sincerely yours,
Mike Rapoport
