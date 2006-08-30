Return-Path: <cclo@astri.org>
Received: from asiwss02.astri.org (mail2.astri.org [203.198.202.21])
	by ozlabs.org (Postfix) with ESMTP id 935AA67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 21:52:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Subject: DS1302 driver for powerpc
Date: Wed, 30 Aug 2006 19:54:16 +0800
Message-ID: <A7B1E4DD46AA7046A4398F745240F29402737D5B@ASPROEXG.astri.local>
From: "Chun Chung Lo" <cclo@astri.org>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I am now doing a STB project and the development board uses a DS1302
(trickle charge timekeeping chip) as a RTC. Our board is a IBM PPC405EP
with a linux kernel 2.4.20 running on it. And the DS1302 is controlled
by 2 GPIO pins instead of I2C.=0D

I would like to ask are there any porting of DS1302 support under ppc
architecture? (I can only find DS1302 is supported under cris
architecture.)

Thanks all.

Best regards,
Lo Chun Chung

This message (including any attachments) is for the named addressee(s)'s=
 use only. It may contain
sensitive, confidential, private proprietary or legally privileged=
 information intended for a
specific individual and purpose, and is protected by law. If you are not=
 the intended recipient,
please immediately delete it and all copies of it from your system, destroy=
 any hard copies of it
and notify the sender. Any use, disclosure, copying, or distribution of=
 this message and/or any
attachments is strictly prohibited.
