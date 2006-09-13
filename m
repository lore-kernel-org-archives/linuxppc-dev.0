Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0F29767B78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 04:37:12 +1000 (EST)
Message-ID: <45084EA3.5020708@anagramm.de>
Date: Wed, 13 Sep 2006 20:32:03 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Jamie Guinan <guinan@bluebutton.com>
Subject: Re: Any PPC system with working USB 2.0 host
References: <Pine.LNX.4.64.0609111140260.6892@gemini.home.net>
In-Reply-To: <Pine.LNX.4.64.0609111140260.6892@gemini.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Jamie,

> I'm trying to get ahold of a low-power, small form factor system with 
> support for USB 2.0 hi-speed host.  PPC would appear to be a good 
> solution for this.

We are in prototype status of our embedded framegrabber product which
is based on a MPC8540/825MHz + GbE + Promise SATA (PDC20775) +
Philips 4x USB2.0 (ISP1563) + SM501 Graphics + FPGA on Local Bus
for 150MByte/sec DMAing into RAM in a 165mm x 125mm x 49mm box with
160GB HDD + 6.5" TFT Display + LiIon-Batteries .

It's based on the latest Linux stuff. The system is able to work as a
standalone host, so you compile your stuff directly on that box..

If you are interested, feel free to contact me off list.
(Enough advertisement for now. ;-)

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
