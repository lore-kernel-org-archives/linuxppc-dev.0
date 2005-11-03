Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 727BA68596
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Nov 2005 22:11:04 +1100 (EST)
Message-ID: <4369EDD3.1010309@anagramm.de>
Date: Thu, 03 Nov 2005 12:00:35 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Absolut Hunter <absoluthunter@comcast.net>
References: <000901c5e017$91aef880$6405a8c0@absolut>
In-Reply-To: <000901c5e017$91aef880$6405a8c0@absolut>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: SM501 Frame Buffer driver on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Russell,

> I am attempting to bring up a SM501 frame buffer driver on our PPC MPC8280
> board. Using the Denx Kernel 2.4.25 I see that most of this is already
> included in the kernel.

I am using the SM501 on PCI on Kernel 2.6 and updated several things in the
driver - not really the same contstruction area as you are working on.
But if you need some code, please let me know (off-list). I posted some things
in the past in this list and on fb-devel, too - just have a look.

The endianess on PCI on ppc is still an issue (I haven't investigated this
problem further during the last month).

I hope that I'll find some time to setup a webpage to publish that
stuff, soon...

Best regards,

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
