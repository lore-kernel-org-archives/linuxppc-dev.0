Return-Path: <peter.asemann@web.de>
Received: from fmmailgate05.web.de (fmmailgate05.web.de [217.72.192.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7576567A46
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Feb 2005 02:46:11 +1100 (EST)
Received: by fmmailgate05.web.de (8.12.10/8.12.10/webde Linux 0.7) with ESMTP
	id j14FQFXa028238
	for <linuxppc-embedded@ozlabs.org>; Fri, 4 Feb 2005 16:26:15 +0100
Received: from [131.188.52.149] (helo=[131.188.52.149])
	by smtp08.web.de with asmtp (TLSv1:RC4-MD5:128) (WEB.DE 4.103 #192)
	id 1Cx5LS-0005gg-00
	for linuxppc-embedded@ozlabs.org; Fri, 04 Feb 2005 16:26:06 +0100
Message-ID: <4203940F.2010109@web.de>
Date: Fri, 04 Feb 2005 16:26:07 +0100
From: Peter Asemann <peter.asemann@web.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: peter.asemann@web.de
Subject: eldk: compiling linux for custom hardware
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm going to compile embedded power pc linux for a custom hardware.
I use the Denx ELDK.
The Linux Kernel configuration (make menuconfig) asks what machine type
to compile Linux for.
So I have the problem that I do not know which option to choose ("none"
is not an option in the dialogue) and that I also do not know what
choosing one of the existing options actually changes behind the scenes.
I'd like a Linux to drop out that supports my MPC875 chip, works with
the LXT 970A ethernet PHY chip and (if possible) the ISP1301
USB-on-the-go USB chip the board has and supports a serial terminal via
SCC4 via the RXD4/TXD4 signals.

Any hint will be appreciated,

best regards,

Peter Asemann
