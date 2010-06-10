Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 70D28B7D4A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 19:29:21 +1000 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: CAN Subsystem and MPC52xx onboard controller
References: <201006101041.27926.roman.fietze@telemotive.de>
	<20100610085923.GE5333@pengutronix.de>
In-Reply-To: <20100610085923.GE5333@pengutronix.de>
MIME-Version: 1.0
Message-ID: <201006101129.15581.roman.fietze@telemotive.de>
Date: Thu, 10 Jun 2010 11:29:15 +0200
Content-Type: Text/Plain;
  charset="iso-8859-15"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

On Thursday 10 June 2010 10:59:23 Wolfram Sang wrote:

> The mainline kernel works fine here with Phytec based MPC5xxx-boards.

Reading your answer made me hope again, and I just pulled the newest
HEAD from the mainline kernel and tried it once more. Now it compiles.
Thanks for retriggering me again.

All the other's sill have problems, except pengutronix, most of them
with an inconsistency (with the socket CAN files?), which shows up as

  'struct can_bittime_std' declared inside parameter list

in net/can/dev.c:69

So I assume we will switch to the mainline kernel, which we already
use for Atom based x86 development on the MEN boards.


Thanks once more

Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
