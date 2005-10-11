Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id C836368505
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 20:37:28 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 90901FB87E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 12:13:46 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 680FCFB87E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 12:13:46 +0200 (CEST)
Received: from kah.ulm.sysgo.com (kah.sysgo.com [172.40.1.2])
	by donald.sysgo.com (Postfix) with ESMTP id F3D641590FB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 12:13:40 +0200 (CEST)
Received: from gja.ulm.sysgo.com (gja.ulm.sysgo.com [172.40.1.130])
	by kah.ulm.sysgo.com (8.9.3/8.8.8) with ESMTP id MAA22986
	for <linuxppc-embedded@ozlabs.org>; Tue, 11 Oct 2005 12:26:44 +0200
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 11 Oct 2005 12:13:39 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200510111213.39859.g.jaeger@sysgo.com>
Subject: Which PHY connection to use on MPC8541...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi list,

we're currently designing a custon MPC8541 based board having three ethernet connections.
For some reasons, we'd like to use the FCC1 and 2 + TSEC1. From what I see from the
docs, it should be no problem to connect i.e. a quad phy (for FCC1/2) and a gigabit phy
(for TSEC1) to the EC_MDIO of the TSEC as long as they have different addresses. 
I don't want to use the GPIO stuff for MDIO.

The question is, what does this mean to the drivers? For the gianfar driver this should
be okay and from what I see, the upcoming fs_enet driver supports also a phy 
connected either to the GPIOs (bitbanging) or the TSEC MDIO. Is this right, or am I
missing something essential? 
Would it be better to use the GPIO-MDIO for the FCC phy and the TSEC-MDIO 
for the TSEC phy?

TIA
Gerhard
