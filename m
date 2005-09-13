Return-Path: <clemens.koller@anagramm.de>
Message-ID: <4326AB96.2000608@anagramm.de>
Date: Tue, 13 Sep 2005 12:36:06 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: KylongMu <mqy@263.net.cn>
References: <20050913045242.7EF2C82D@smtp.263.net>
In-Reply-To: <20050913045242.7EF2C82D@smtp.263.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: New message about: "Lost interrupt" with promise20268 PCI-IDE
 chard	onmpc8540_ads
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, KylongMu, Rune!

(Please reply to the thread.)

> 	First I according  Clemens Koller' suggestion : remove DMA part ,
> but the result is no change.

Okay, sorry if my 'workaround' (let's call it 'cheat') didn't do it for you...

> According Clemens Koller's message , I guess mabe the problem is on the
> hardware configuration.
> So I checked my schematics and
> "arch/ppc/platforms/85xx/mpc85xx_ads_common.c" at line 170 .
> The attached file is changed .
> 	After these , "Lost interrupt" appears on PCI1-Slot1 , but my
> PCI1-Slot2 shows no "Lost interrupt"
> the .config file is still without change .
> 	Another new problem is I can't mount it on , I attached the steps
> message of new operation.
> Please help me check it .

To be honest, I didn't tell you that there are still issues with my
mpc85xx_map_irq() and friends(). I didn't fix the table for my board
yet as the official CR854 demo board has only on PCI slot and I just
didn't care about proper IDSEL->IRQ mapping.
The hardware add-on we design should be compatible to the ADS board (or to
be precise to the default mpc8540_ads behaviour in the kernel) as much
as possible, so there should be no need for a separate platform port.

> Rune Torgersen wrote :
>>I have run a Silicon Image SiI0680 based card on a MPC8560ADS board without
> problems

Yes, but AFAIK it's only 32bit/33MHz PCI and therefore not speedy enough for
the things we want to achieve (100..200Mbyte+/sec).
So, this problem with the PDC has to be fixed... but it will take some time.

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
