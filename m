Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DE01567BE6
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 16:51:36 +1000 (EST)
Message-ID: <453F095E.4060106@s5r6.in-berlin.de>
Date: Wed, 25 Oct 2006 08:51:10 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pci_set_power_state() failure and breaking suspend
References: <1161672898.10524.596.camel@localhost.localdomain>
	<1161675611.10524.598.camel@localhost.localdomain>
	<tkrat.1b479115136413cf@s5r6.in-berlin.de>
	<453F08A0.9040506@s5r6.in-berlin.de>
In-Reply-To: <453F08A0.9040506@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux1394-devel@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

And this should go on top of ohci1394_pci_suspend:

+	printk(KERN_INFO "%s does not fully support suspend yet\n",
+	       OHCI1394_DRIVER_NAME);
+
-- 
Stefan Richter
-=====-=-==- =-=- ==--=
http://arcgraph.de/sr/
