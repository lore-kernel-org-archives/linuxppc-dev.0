Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A1E1DE0A7
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 01:23:39 +1000 (EST)
Subject: Re: gianfar in SGMII mode
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1215039186.7559.548.camel@localhost.localdomain>
References: <1215039186.7559.548.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 03 Jul 2008 10:23:31 -0500
Message-Id: <1215098611.7559.551.camel@localhost.localdomain>
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

On Wed, 2008-07-02 at 17:53 -0500, Nate Case wrote:
> I'm looking at gfar_configure_serdes() and I'm at a loss as to why
> this
> is always called when the MAC is in SGMII mode.  It looks like it
> assumes the use of TBI for some reason.  On my board it's just a
> regular
> SGMII interface to a bcm5482 PHY in SGMII mode, so there is no TBI
> involved.
> 
> I'm guessing this is a case of the driver making incorrect assumptions
> based on the existing Freescale boards.  Or am I missing something
> here? 

Answering my own question: I see now that TBI is used internally on the
chip for the SerDes interface which implements SGMII..  so maybe there's
no problem with what the driver is doing after all.

-- 
Nate Case <ncase@xes-inc.com>
