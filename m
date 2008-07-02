Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E90B7DDF0F
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 08:53:14 +1000 (EST)
Subject: gianfar in SGMII mode
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 02 Jul 2008 17:53:06 -0500
Message-Id: <1215039186.7559.548.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

I'm looking at gfar_configure_serdes() and I'm at a loss as to why this
is always called when the MAC is in SGMII mode.  It looks like it
assumes the use of TBI for some reason.  On my board it's just a regular
SGMII interface to a bcm5482 PHY in SGMII mode, so there is no TBI
involved.

I'm guessing this is a case of the driver making incorrect assumptions
based on the existing Freescale boards.  Or am I missing something
here? 

-- 
Nate Case <ncase@xes-inc.com>
