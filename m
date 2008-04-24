Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32C6BDDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 18:35:10 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m3O8YusJ002357
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 10:34:56 +0200
Message-ID: <07c101c8a5e6$13670980$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: ML405 failed reboot
Date: Thu, 24 Apr 2008 10:34:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that my Xilinx card is operational with Kernel 2.6.24 and a 
buildroot/busybox/uClibc config, I'm getting on the application side.

First hitch: I can't do a soft reboot of the card:

# reboot
The system is going down NOW!
Sending SIGTERM to all processes
Requesting system reboot
[  434.713999] Restarting system.
[  434.7[  434.718123]   Signal: 4
[  434.718133]   Code:   30001
[  434.718144]   Addr:   c74cbdc8

And then it just hangs.
I also tried the additional -n (no sync) and -f (force) without difference.

Design problem ?
Any other way to force a reboot ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/
