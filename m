Return-Path: <jaap.dejong@nedap.com>
Received: from smtp2.nedap.com (smtp2.nedap.com [213.160.213.92])
	by ozlabs.org (Postfix) with ESMTP id 76BFD689F9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 19:26:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Re: Getting started with Xilinx V4 PPC? (David Summers)
Date: Wed, 1 Feb 2006 09:14:03 +0100
Message-ID: <6915D0AE8B9047438F320B466AE30FDD15256A@nvs0003.nedap.local>
From: "Jaap de Jong" <jaap.dejong@nedap.com>
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

Hi David,

I am working on the same board as you do, using the montavista linux 2.4
distribution and the eldk 3.1.1 environment.
With some minor patches I've got it working with the soft ethernet core,
the uartlite and the flash (although I'm still having some trouble with
the flash).=20
In the fpga design you have to change some settings to get this working
too; the default will fail.
I can give you the details I've found if you like.

Good luck!

	Jaap de Jong
