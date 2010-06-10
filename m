Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8B27BB7D7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 18:48:15 +1000 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 6E382C00C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 10:41:28 +0200 (CEST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: CAN Subsystem and MPC52xx onboard controller
MIME-Version: 1.0
Message-ID: <201006101041.27926.roman.fietze@telemotive.de>
Date: Thu, 10 Jun 2010 10:41:27 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello List Members,

I have tried multiple versions/branches and git repos (torvalds,
benh/{next,master}, denx, pengutronix, ...) to get a 2.6.34 or HEAD
version of that repos that compiles w/o errors when the CAN subsystem
is enabled and the MPC5xxx onboard driver is selected starting with
the lite5200b_defconfig.

Until now I'm out of luck. If other's also have compile problems I can
of course offer to try to dig into the sources.

Q0:

I'm somewhat unsure what repos to use in general to develop using the
2.6 on a Lite5200B compatible board (for the 2.4 we always used the
DENX repos).

Q1:

And which one is "good" or "better" for CAN+MPC52xx if that's
different?


Thanks for any enlightenment


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
