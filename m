Return-Path: <bdc@carlstrom.com>
Received: from electricrain.com (electricrain.com [207.7.145.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A466679EB
	for <linuxppc-dev@ozlabs.org>; Sun, 14 May 2006 17:23:40 +1000 (EST)
From: "Brian D. Carlstrom" <bdc@carlstrom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17510.55656.607530.491585@zot.electricrain.com>
Date: Sun, 14 May 2006 00:16:56 -0700
To: Juergen Kreileder <jk@blackdown.de>
Subject: Load average 1.0 on idle machine
In-Reply-To: <87wtcplejw.fsf@blackdown.de>
References: <87wtcplejw.fsf@blackdown.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: "Brian D. Carlstrom" <bdc@carlstrom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Juergen Kreileder writes:
 > with both 2.6.16.11 and 2.6.17-rc4 my PowerMac G5 Quad shows a load
 > average of 1.0 when the machine is completely idle (just kernel, init,
 > and bash running).

I see this as well, with the load coming from "kwindfarm". I just
assumed this was expected because of the userlevel thermal control
versus the older in kernel code for the PowerMac7,2 and 7,3 machines.

-bri
