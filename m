Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.2.87]) by ozlabs.org (Postfix) with ESMTP id BCE0967A82
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 10:09:10 +1100 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2LN962k022391
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Mar 2005 00:09:06 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (72.155-200-80.adsl.skynet.be
	[80.200.155.72])
	by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2LN92Va022383
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Mar 2005 00:09:02 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from localhost.localdomain (246tNt-laptop.lan.ayanami.246tNt.com
	[10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id 0FBEB110E1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 00:06:47 +0100 (CET)
Message-ID: <0.20050322_000905.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 22 Mar 2005 00:06:47 +0100 (CET)
Subject: [PATCH 0/6] [RFC] Change MPC52xx to platform bus / ppc_sys model
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

This series of patch changes all the MPC52xx related code
to use platform bus and ppc_sys instead of OCP. It's
divided in several patches that represents "steps" in
the conversion. However the intermediate states might
not be functionnal.

This is the first try, comments and suggestions are
welcomed.


	Sylvain
