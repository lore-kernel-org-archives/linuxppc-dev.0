Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 78472DDED1
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Apr 2008 23:50:27 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 3BB722276DF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Apr 2008 15:40:18 +0200 (CEST)
Received: from [10.0.30.2] (p5497C5C8.dip.t-dialin.net [84.151.197.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 2E5E09004D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Apr 2008 15:40:15 +0200 (CEST)
Message-ID: <47FB75BC.10400@grandegger.com>
Date: Tue, 08 Apr 2008 15:40:12 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: TSEC3/4 broken on MPC8548?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

in the dts file for the MPC8548CDS the nodes for TSEC3/4 are commented
out because they seem to be broken:

  $ grep broken arch/powerpc/boot/dts/*
  arch/powerpc/boot/dts/mpc8548cds.dts:/* eTSEC 3/4 are currently broken

Is it still true?

TIA.

Wolfgang.
