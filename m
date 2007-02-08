Return-Path: <juergen.beisert@weihenstephan.org>
Received: from bill.weihenstephan.org (bill.weihenstephan.org [82.135.35.21])
	by ozlabs.org (Postfix) with ESMTP id F3E6ADDF45
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 04:36:21 +1100 (EST)
Received: from jupiter.intranet.kreuzholzen.de (p54986744.dip.t-dialin.net
	[84.152.103.68])
	by bill.weihenstephan.org (Postfix) with ESMTP id 7FC8151C677
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 18:13:34 +0100 (CET)
From: Juergen Beisert <juergen.beisert@weihenstephan.org>
To: linuxppc-embedded@ozlabs.org
Subject: How to detect fsystem clock on MPC5200
Date: Thu, 8 Feb 2007 18:13:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200702081813.35776.juergen.beisert@weihenstephan.org>
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

currently I am writing an SPI driver for a PSC unit. To calculate the baudrate 
this unit should use I need the fsystem frequence (fsystem is the used name 
in the datasheet). Is there a generic way (API) to read back this clock?

For the IPB clock I found mpc52xx_find_ipb_freq() from the open firmware 
framework. Is there something similar for the fsystem clock?

Juergen
