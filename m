Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 44452B7BFC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 16:32:57 +1000 (EST)
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id C5A15DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 16:32:56 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	2522011A725
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 08:32:53 +0200 (CEST)
Received: from [192.168.1.6] ([87.97.84.156])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KOP00G89RIT9S50@invitel.hu> for
	linuxppc-dev@ozlabs.org; Fri, 21 Aug 2009 08:32:53 +0200 (CEST)
Date: Fri, 21 Aug 2009 08:39:36 +0200
From: Heiko Schocher <hs@denx.de>
Subject: 832x: MATH_EMUL
To: linuxppc-dev@ozlabs.org
Message-id: <4A8E4128.6040905@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I actually porting a mpc8321 based port, and because there is no FPU
on this CPU, I activated MATH_EMUL, as all other mpc832x ports did.

Is there something like a counter, which counts how many times this
Exception occurs?

Thanks.

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
