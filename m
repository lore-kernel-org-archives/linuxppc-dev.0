Return-Path: <puggy@gentoo.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [134.68.220.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4ED4689DD
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jan 2006 06:41:34 +1100 (EST)
Received: from bartlemas35.plus.com ([80.229.152.252] helo=[192.168.2.3])
	by smtp.gentoo.org with esmtpa (Exim 4.54) id 1F0NY5-0002hS-P9
	for linuxppc-dev@ozlabs.org; Sat, 21 Jan 2006 18:33:17 +0000
From: Douglas Russell <puggy@gentoo.org>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.16-r1 sound
Date: Sat, 21 Jan 2006 18:33:05 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200601211833.06139.puggy@gentoo.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ALSA sound seems to have stopped working under 2.6.16-rc1 on my powerbook 5,6. 
The kernel just doesn't seem to find a sound device. It works fine when I go 
back to 2.6.15-rc5 which I was on before.

Cheers
