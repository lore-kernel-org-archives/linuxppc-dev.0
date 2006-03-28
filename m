Return-Path: <Jeff.Fellin@rflelect.com>
Received: from noteshub1.teal.com (mail.teal.com [67.155.213.211])
	by ozlabs.org (Postfix) with ESMTP id 0160E67A60
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 03:36:12 +1100 (EST)
Subject: PPC405EP and Abatron BDI help
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF3A743E50.87BEEA66-ON8525713F.00587402@teal.com>
From: Jeff.Fellin@rflelect.com
Date: Tue, 28 Mar 2006 11:36:05 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I'm not sure if this forum can help me, but perhaps someone has experience
with
using an Abatron BDI2000 to control an AMCC PPC405EP evaluation board. I am
having problems with getting the BDI to access devices on the external bus.
I have verifed the EBC settings are correct by comparing them to the values
set by Uboot 1.1.2 (Jun 2, 2005 Rev B) running on the board.

I have used the base bubinga.cfg , Stefan Roese's configuration file, sent
to me
from someone on this mailing list. I modified the configuration to match
the external
device configuration of the AMCC PPC405EP evaluation board.

Any ideas as to why I cannot access devices on the external bus using the
BDI,
but Uboot can?


 Jeff Fellin
RFL Electronics
Jeff.Fellin@rflelect.com
973 334-3100, x 327
