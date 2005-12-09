Return-Path: <absoluthunter@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc14.comcast.net [216.148.227.89])
	by ozlabs.org (Postfix) with ESMTP id CA1C768871
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Dec 2005 06:24:43 +1100 (EST)
From: "Absolut Hunter" <absoluthunter@comcast.net>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 9 Dec 2005 11:16:57 -0800
Message-ID: <003101c5fcf5$1ff05b80$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: 82xx-HCI-USB & Webcams / PWC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

I realize mostly this topic is probably best reserved for the video4linux
mailing list, but my question is more regarding just if anyone has had
success with the default kernel options with no modifications... 

Or perhaps if my issue relates to USB driver performance... Read on.

Has anyone attempted to use the Phillips web cam driver, pwc.o, that is
built into the standard 2.4.25 DENX kernel? I think its version 8.x
something.

I have been attempting to use a console based capture program to just see if
I can get low resolution captures to work. I have installed the 82xx-HCI usb
driver, have got all the v4l, and PWC kernel modules installed and
everything is recognized. 

I am able to capture some video images, but always have like 50% or better
image corruption, like horizontal green/pink stripes across the video image,
or pure green static. I was curious if anyone had tried this. I know some
other folks have had problems with USB data integrity using this usb driver,
especially under high loads like a usb camera might provide.

Anyone tried this?

I have successfully gotten mice and keyboards to work under this USB driver
so it seems to work at low data rates.

-Russ
