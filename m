Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 27ABCDE005
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 02:24:25 +1000 (EST)
Message-ID: <49EDF333.4000200@mlbassoc.com>
Date: Tue, 21 Apr 2009 10:24:19 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: PCI changes 2.6.26 => 2.6.28
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I had a stable port of 2.6.26 for my 834x hardware, with a
frame buffer on a PCI device.  After I upgraded to 2.6.28,
this isn't working any more.  The frame buffer code is happily
writing to a mapped [memory] space on the PCI card, but nothing
is happening.

Did something [subtle] change in how the PCI is handled in
this timeframe?  Perhaps with how PCI devices are mapped or
enabled?  I've looked at the changes between the two versions,
but nothing leaps out at me.

n.b. I have other devices on the PCI bus, such as a SATA
controller, which work the same in both versions.

Thanks for any ideas

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
