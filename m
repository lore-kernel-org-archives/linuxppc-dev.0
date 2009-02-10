Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19A24DDDA5
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 03:02:34 +1100 (EST)
Message-ID: <4991A4F2.8030506@freescale.com>
Date: Tue, 10 Feb 2009 10:01:54 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for
	I2C   to complete
References: <1233928837-3401-1-git-send-email-timur@freescale.com>	<ed82fe3e0902100659p2eec9de6j61f9ffb504d60a89@mail.gmail.com>
	<20090210165554.0da8bf7c@hyperion.delvare>
In-Reply-To: <20090210165554.0da8bf7c@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean Delvare wrote:

> No, that's something for either Ben Dooks (Cc'd) or the powerpc tree.

This patch has nothing to do with ARM, so Kumar will pick it up, if you
ACK it.

-- 
Timur Tabi
Linux kernel developer at Freescale
