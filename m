Return-Path: <roman.fietze@telemotive.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3899FB708E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 23:51:48 +1000 (EST)
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id BB996DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 23:51:47 +1000 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 8D131BC4BB
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 15:45:30 +0200 (CEST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@ozlabs.org
Subject: MTD OF parser problem
MIME-Version: 1.0
Message-ID: <200907071545.30121.roman.fietze@telemotive.de>
Date: Tue, 7 Jul 2009 15:45:29 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hallo,

I tried to define my MTD partitions in a device tree as
documented. The function of_flash_probe() inside teh file physmap_of.c
never compiled the code below

#ifdef CONFIG_MTD_OF_PARTS

because when the MTD subsystem is compiled as a module I can only find
CONFIG_MTD_OF_PARTS_MODULE beeing defined somewhere below my build
directory.

If I change the above define to

#if defined(CONFIG_MTD_OF_PARTS) || defined(CONFIG_MTD_OF_PARTS_MODULE)

everything is fine and MTD partition work as expected.

My fault? Other solution?

If not, I can submit that tiny patch.


Thanks


Roman

=2D-=20
Roman Fietze  Telemotive AG  B=FCro M=FChlhausen
