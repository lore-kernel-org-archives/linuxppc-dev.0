Return-Path: <felix_schmidt@web.de>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by ozlabs.org (Postfix) with ESMTP id A8DA7DDFA5
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 01:57:09 +1000 (EST)
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7BF3FEB8E2CF
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 17:30:22 +0200 (CEST)
Received: from [77.191.193.243] (helo=[192.168.0.25])
	by smtp07.web.de with asmtp (WEB.DE 4.109 #226) id 1KVpde-0002Ao-00
	for linuxppc-dev@ozlabs.org; Wed, 20 Aug 2008 17:30:22 +0200
Message-ID: <48AC388D.1090609@web.de>
Date: Wed, 20 Aug 2008 17:30:21 +0200
From: Felix Schmidt <felix_schmidt@web.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: cache model of ppc
Content-Type: text/plain; charset=ISO-8859-15
Sender: felix_schmidt@web.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 
Dear,

I some questions about the PowerPC cache model.

How many caches are there?
How many caches are in multi-core systems? do you have a L1 cache per
cpu and one shared L2? or is there a victim L3 cache?

can you tell me something about the path through the cache?
for example I look up for data in L1, but this was a miss. Then i look
up in L2 this was also a miss. but the date will be in another L1
cache of another cpu. Is there a 1.5 or 2.5 hit?

can you help me please?
this is for my bachelorthesis

thanks a lot

felix
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
 
iEYEARECAAYFAkisOIwACgkQmH8OAwYoDBk0ugCgu6zzJEQWA9NldC4ekjOcWgIu
cYIAoMquvbvAf/qA1WmjtROpq+R1X6Yb
=JepB
-----END PGP SIGNATURE-----
