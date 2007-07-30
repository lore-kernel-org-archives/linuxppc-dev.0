Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07B68DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 03:02:10 +1000 (EST)
Subject: I2C interrupts on 8541
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 30 Jul 2007 09:51:44 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A2A4@MERCURY.inside.istor.com>
In-Reply-To: <11816893411272-git-send-email-grant.likely@secretlab.ca>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Mark Freedkin <mfreedkin@istor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm puzzled about how to setup interrupts for the second I2C interface
in an 8541. This is the CPM interface, the one with buffer descriptors.

I see mention of its I2CER/I2CMR registers, but am having trouble
figuring out how to enable and interrupt so that when the interface is
in slave mode and a packet is received, it will vector to an interrupt
service routine.

I am using Linux-2.7.17.11 and I know you-all have gone past this a bit,
but in the midst of a project, we are constrained to finish with the
kernel we started with.

A few pointers on enabling an interrupt from this interface would be
greatly appreciated.

Charles
