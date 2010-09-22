Return-Path: <m.johansen@no.parkairsystems.com>
Received: from mail1.parkairsystems.no (mail1.parkairsystems.no
	[195.204.13.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A7B7B70DB
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 20:40:15 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail1.parkairsystems.no (Postfix) with ESMTP id 13AB5B350
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 12:31:39 +0200 (CEST)
Received: from mail1.parkairsystems.no ([127.0.0.1])
	by localhost (mail1.parkairsystems.no [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 6ne2MQU+8glA for <linuxppc-dev@ozlabs.org>;
	Wed, 22 Sep 2010 12:31:35 +0200 (CEST)
Received: from Exchange.parkairsystems.net (exchange.parkairsystems.net
	[172.20.0.63])
	by mail1.parkairsystems.no (Postfix) with ESMTP id 6243EB347
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 12:31:35 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Modifying mpc8308rdb.dts
Date: Wed, 22 Sep 2010 12:32:20 +0200
Message-ID: <DF61B4AD1C20A54EADF5C05E1F1110DE08D43B@Exchange.parkairsystems.net>
From: "Maria Johansen" <m.johansen@no.parkairsystems.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am working on an MPC8308rdb, and have needed to add support for spi
and an lm75 thermal sensor on the i2c-bus. Is it possible to upload my
changes to the "official" mpc8308rdb.dts, or should I just keep
modifying it locally and hope the maintainers of the file will add
support for more devices soon?

I apologize if this may seem like a silly question, but this is the
first time I feel the need to add something into the official kernel :)=20

--=20
Regards,
Maria
