Return-Path: <tnt@246tNt.com>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.2.116]) by ozlabs.org (Postfix) with ESMTP id 101DF67A79
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Mar 2005 09:47:12 +1000 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2QNl2MK022819
	for <linuxppc-embedded@ozlabs.org>; Sun, 27 Mar 2005 00:47:03 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <0.20050327_004704.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Date: Sun, 27 Mar 2005 00:44:43 +0100 (CET)
Cc: Sylvain Munaut <tnt@246tNt.com>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 0/6] Change MPC52xx to platform bus / ppc_sys model
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Andrew,

This series of patch changes all the MPC52xx related code
to use platform bus and ppc_sys instead of OCP. It's
divided in several patches that represents "steps" in
the conversion. However the intermediate states might
not be functionnal.

Theses are against a bk clone of this morning since they
depend on some patches that are on bk but not yet in
2.6.12-rc1. I just tested and they also apply/run fine
with -mm3.


Regards,

	Sylvain
