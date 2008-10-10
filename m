Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8AD6CDE252
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 01:03:22 +1100 (EST)
Received: from [172.26.6.73] ([172.26.6.73]) (authenticated bits=0)
	by xseries02.selcomgroup.com (8.13.4/8.13.4) with ESMTP id
	m9ADbLmc023497
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 15:37:21 +0200
Message-ID: <48EF5A94.3070707@selcomgroup.com>
Date: Fri, 10 Oct 2008 15:37:24 +0200
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: kernel 2.6.27 MPC512x status
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I gave a try to the brand new 2.6.27 kernel on my ADS5121 evaluation board:

    * FEC support is not in, though it was quite easy to add FSL patches
      from 2.6.24.6 and have the ethernet working
    * If I turn on any USB support, the board resets itself as soon as
      the USB driver is loaded. Without USB, I can get to a prompt.
      Funny that the software reset is not working, but this bug is
      actually able to sw reset the board...
    * PCI seems not to be working, but I need to test it more. The fact
      that FSL needed to patch 2.6.24.6 in order to get PCI working
      makes me think it's needs some work.

This is bad because I wanted to incorporate some newer patches, like the 
PWM one, but kernel 2.6.24.6 is too backward in time, while 2.6.27 is 
too forward for FSL patches...

M
