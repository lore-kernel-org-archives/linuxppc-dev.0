Return-Path: <ingvar@linpro.no>
Received: from head.linpro.no (head.linpro.no [80.232.36.1])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E19ED67BA8
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 23:48:43 +1000 (EST)
Received: from stat.linpro.no ([80.232.36.97])
	by head.linpro.no with esmtp (Exim 4.14 #1 (Debian))
	id 1GF9rJ-000549-8B
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 15:30:29 +0200
Received: from uname.e.linpro.no ([192.168.43.140])
	by stat.linpro.no with esmtp (Exim 4.50) id 1GF9rI-0007Lr-AT
	for linuxppc-dev@ozlabs.org; Mon, 21 Aug 2006 15:30:28 +0200
Message-ID: <44E9B573.1090403@linpro.no>
Date: Mon, 21 Aug 2006 15:30:27 +0200
From: Ingvar Hagelund <ingvar@linpro.no>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Using a file as blockdevice for vscsi host
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: ingvar@linpro.no
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think someone, sometime told me something about using a file as vscsi
device in a (Linux) vio server. Is this possible?

I tried this, but it doesn't seem to work:

vios# dd if=/dev/zero of=/path/to/sysvol bs=1M count=9000
viod# cd sys/bus/vio/devices/30000020/bus0
vios# echo 2 > num_targets
vios# cd target1
vios# echo /path/to/sysvol > device
vios# echo b > type
vios# echo 1 > active
vios# echo $?
1
vios# cat active
0

Ingvar


-- 
Blogs are the new usenet
(Mike of UserFriendly.org)
