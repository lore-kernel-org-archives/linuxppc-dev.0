Return-Path: <nst@gersys.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id A9D84DDFA0
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 03:52:47 +1100 (EST)
Message-ID: <496E172D.9060304@gersys.de>
Date: Wed, 14 Jan 2009 17:47:41 +0100
From: Stefan Strobl <nst@gersys.de>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: ADS5121 how to use /dev/ttyPSC
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I'm new to Kernel 2.6 and OF.

I'm using a ADS5121 board with kernel from denx (ads5121 branch from
linux-2.6-denx). According to my dts file both PSC3 and PSC4 should be
accessible through /dev/ttyPSC0 and /dev/ttyPSC1 respectively.

When I simply try to run: "$ echo "Hello" > /dev/ttyPSC*" I can't see
any data coming out from the ports.
And when trying to initialize the ports using termios commands I'm
getting the Error "Inappropriate ioctl for device".
I'm not even getting a negative voltage on the TX Pin (idle state).
But I can see the driver ttyPSC with major 204 in /proc/devices and I
can also open the device successfully. I am also able to configure
either port as CONSOLE in U-Boot so the Hardware is ok.

Any ideas?
Many thanks,
Stefan
