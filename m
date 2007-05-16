Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1216DDEDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 08:08:25 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Accessing 8541 registers from user space
Date: Wed, 16 May 2007 14:59:22 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A210@MERCURY.inside.istor.com>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C017BA257@ehost011-3.exch011.intermedia.net>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Randy Brown <rbrown@istor.com>, Vahid Fereydounkolahi <vahidf@istor.com>,
	Chris Carlson <ccarlson@istor.com>, Kevin Smith <ksmith@istor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a need to be able to read and write the gpio data registers PDATC
and PDATD from a user space program.=20

We have a userspace program that succesfully mmaps an offset in /dev/mem
and reads/writes registers in a CPLD at 0xFF00_0000.

The issue seems to be that when I mmap /dev/mem to 0xE000_0D50 to read
the PDATC register, Linux-2.6.17.11 just locks up.

Can anyone shed a little light on why this could be happening?

Charles Krinke
