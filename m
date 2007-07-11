Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id A9CFFDDE27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 21:02:39 +1000 (EST)
Message-ID: <4694B8C9.8010209@anagramm.de>
Date: Wed, 11 Jul 2007 13:02:33 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxdev <sahil.satpute@gmail.com>
Subject: Re: Porting kernel 2.6.11 to WindRiver board.
References: <11459454.post@talk.nabble.com>
In-Reply-To: <11459454.post@talk.nabble.com>
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

linuxdev schrieb:
> I have to port a linux kernel to Motorola MPC 7447 based WindRiver SBC 7447
> board.

The MPC7447 is one of the G4+ PowerPC processor series.
You shouldn't run into much issues to get Linux running on it.

A good start can be to use the latest ELDK from http://www.denx.de.

I created a native PowerPC environment for embedded use based on the
latest CRUX linux distribution (http://cruxppc.sunsite.dk).
CRUX is also available for x86 (http://crux.nu) which is nice
to work completely platform independent.

> I plan to use Kernel 2.6.11 and Uboot for the same.

It doesn't make sense to use an older than the latest Kernel because
nobody wants to help you in case you run into problems.
Use the latest linux git tree. (or at least some 2.6.22)
And use the latest U-Boot git tree. (also from denx)

 > I wanted to know whether
> these two can be used for the board. Also how do I get hold of a BSP for
> this board and kernel? Are there any information resources for the same?

It's all available in the web. It depends on your hardware setup
how complicated your "porting" might be. I hope you good good documentation
for it.
If you have a Harddisk to boot from or some network interface, "porting"
it might be as simple as installing some x86 platform.

> Thanks in advance...
> LinuxDev.
Please use your real name.

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
