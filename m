Return-Path: <r.buergel@unicontrol.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.161])
	by ozlabs.org (Postfix) with ESMTP id 5E760DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 04:35:17 +1100 (EST)
Received: from obelix.unicontrol.de
	(pd907c61f.dip0.t-ipconnect.de [217.7.198.31])
	by post.webmailer.de (mrclete mo43) (RZmta 17.14)
	with ESMTP id Q00e00k9TGaYkv for <linuxppc-dev@ozlabs.org>;
	Wed, 29 Oct 2008 18:24:11 +0100 (MET)
	(envelope-from: <r.buergel@unicontrol.de>)
Received: from localhost (localhost [127.0.0.1])
	by obelix.unicontrol.de (Postfix on SuSE Linux 8.1 (i386)) with ESMTP
	id B83DF17DFC
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 18:23:51 +0100 (CET)
Received: from [192.168.1.55] (arkturus.unicontrol.de [192.168.1.55])
	by obelix.unicontrol.de (Postfix on SuSE Linux 8.1 (i386)) with ESMTP
	id 3122317DF9
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 18:23:48 +0100 (CET)
Message-ID: <49089BD3.9090705@unicontrol.de>
Date: Wed, 29 Oct 2008 18:22:27 +0100
From: =?ISO-8859-15?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc52xx_uart: report serial errors to users
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi! This patch adds the capability to the mpc52xx-uart to report framing 
errors, parity errors, breaks and overruns to userspace. These values 
may be requested in userspace by using the ioctl TIOCGICOUNT.

Signed-off-by: René Bürgel <r.buergel@unicontrol.de>

Kind regards, René Bürgel

-- 
René Bürgel
Software Engineer
Unicontrol Systemtechnik GmbH
OT Dittersbach
Sachsenburger Weg 34
09669 Frankenberg
 
Tel.: 03 72 06/ 88 73 - 19
Fax: 03 72 06/ 88 73 - 60
E-Mail: r.buergel@unicontrol.de
Internet: www.unicontrol.de
