Return-Path: <jangiels@speakeasy.net>
Received: from mail1.speakeasy.net (mail1.speakeasy.net [216.254.0.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0B5D2BD6A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2004 03:28:36 +1000 (EST)
Received: from dsl017-104-254.spk0.dsl.speakeasy.net (HELO [192.168.0.10])
	(jangiels@[69.17.104.254]) (envelope-sender <jangiels@speakeasy.net>)
	by mail1.speakeasy.net (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 11 Oct 2004 17:21:54 -0000
From: Jeff Angielski <jangiels@speakeasy.net>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1097515329.8508.66.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Mon, 11 Oct 2004 13:22:09 -0400
Subject: Creating rootfs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


So how are people creating the rootfs for their embedded target these
days?  Busybox?  PTX?  Strip down some existing filesystem?

I have an opportunity to start "fresh" with our current rootfs and could
not find anything definitive when google-ing for solutions.  So I am
curious to hear what the rest of the community is using.


Jeff Angielski
