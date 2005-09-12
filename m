Return-Path: <mqy@263.net.cn>
From: "KylongMu" <mqy@263.net.cn>
To: <Linuxppc-embedded@ozlabs.org>
Date: Mon, 12 Sep 2005 23:57:47 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-Id: <20050912155800.C8E76A4E@smtp.263.net>
Subject: Re Re: "Lost interrupt" with promise20268 PCI-IDE chard on
	mpc8540_ads
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 

Hi Koller
	Thanks for you help , I'll try what you tell me tomorow , and sand
back the test result to you , but which PCI-IDE bridge will support DMA on
MPC8540 ? I wonder the bandwidth of IDE will be a bottleneck of my system
requirement .

Thanks a lot !

KylongMu


Hi KylongMu!

KylongMu wrote:
> Hi, all
>         Please help solve this problem , or give me some advise .
> Thanks a lot !

Try to turn off DMA. It doesn't work yet AFAIK.
I am using a PDC20269 on PCI on a MPC8540, too. See my .config file...
I didn't focus on this problem yet. Let me know if you get it going.

My board PM854 is similar to the MPC8540_ADS

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
