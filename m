Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 033FCDDFC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 07:52:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: PHY link up/down looping
Date: Thu, 26 Apr 2007 17:53:18 -0400
Message-ID: <3C02138692C13C4BB675FE7EA2409529328A9D@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
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

Hello,

Has anybody here had the problem where upon the linux 2.6 kernel
booting, the PHY link seems to be in some kind of auto-negotiating loop
of going up and down? This has been hapenning in my 2.6.19 kernel with a
Marvell PHY (88E1011S). The board i'm working with is similar to the
MPC8555CDS, so i'm using that kernel config for this environment.
=20
Clinton Thomas
