Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id AAFD12BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Oct 2004 03:32:26 +1000 (EST)
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CM83V-0000e5-00
	for linuxppc-embedded@ozlabs.org; Mon, 25 Oct 2004 18:50:49 +0200
Received: from [217.80.229.80] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CM83V-0005Kf-00
	for linuxppc-embedded@ozlabs.org; Mon, 25 Oct 2004 18:50:49 +0200
Message-ID: <417D2EED.50205@anagramm.de>
Date: Mon, 25 Oct 2004 18:50:53 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: MPC8540 experience
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, dear list members!

This is my first mail here, so hopefully, everything works fine...

We at Anagramm GmbH, located in Germany/Munich, are planning to setup
an embedded system for our new image grabbing/camera platform
utilizing the Freescale MPC8540 (PowerQUICC III) processor.

I am planning to use tested hardware components for the first
prototyping setup to concentrate on getting things going without
worrying about broken HW. The goal is to get a portable
solution with fast interfaces for about 10..50+ MBytes/s throughput.
(Local Bus Bulk Data/IO or RapidIO or GPIO to Gigabit Ethernet)

Additionally we want to add up an interface for a small TFT Panel.
I think about putting a Silicon Motion (SMI) Graphics controller (SM712 
or SM501) on the PCI bus. I am already in contact with SMI about HW/SW 
support from them.

I think about porting some old xfree drivers from SMI to a current
2.4 or 2.6 kernel or writing a framebuffer device driver for the 
graphics. Is there anybody with a similar setup and/or some similar 
tasks to get Linux with X11 to work on targets like this?
Later on we want to port our image processing environment and
a Qt-GUI to the platform for some products.

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
