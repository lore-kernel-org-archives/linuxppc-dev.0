Return-Path: <jitendra.jain@einfochips.com>
Received: from india.einfochips.com (india.einfochips.com [203.88.139.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "india.einfochips.com",
	Issuer "india.einfochips.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8835BDDE19
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 May 2007 16:02:57 +1000 (EST)
Message-ID: <50932.59.95.246.73.1179121634.squirrel@india.einfochips.com>
Date: Mon, 14 May 2007 11:17:14 +0530 (IST)
Subject: NFS: Portmap Sever Not responding
From: jitendra.jain@einfochips.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All,

I am using kernel 2.6.20.
I want to load my kernel on my target board with ARM architecture.
But I am getting the following message and
I am not able to mount NFS file system.


NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Guessing netmask 255.0.0.0
IP-Config: Complete:
      device=eth0, addr=62.0.0.0, mask=255.0.0.0, gw=255.255.255.255,
     host=62.0.0.0, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=192.168.1.214, rootpath=
Looking up port of RPC 100003/2 on 192.168.1.214
portmap: server 192.168.1.214 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.1.214
portmap: server 192.168.1.214 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.1.214 not responding, timed out
Root-NFS: Server returned error -5 while mounting /dhruval/fs/root
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)



What could be the problem, where I am doing the mistake.
I had checked my NFS server is working for another board.

Can anyone pls help me for the same.

Thanks in advance

Regards
Jitendra Jain




eInfochips Business Disclaimer:
This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by eInfochips Limited and/or eInfochips Inc("eInfochips") unless sent with that express intent and with due authority of eInfochips. eInfochips has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
