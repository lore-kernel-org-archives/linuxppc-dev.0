Return-Path: <yamazaki.seiji@kk.jp.panasonic.com>
Received: from smtp.mei.co.jp (smtp.mei.co.jp [133.183.100.20])
	by ozlabs.org (Postfix) with ESMTP id 74040DDF48
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 16:49:41 +1000 (EST)
Received: from mail-gw.jp.panasonic.com ([157.8.1.145])
	by smtp.mei.co.jp (8.12.11.20060614/3.7W/kc-maile13) with ESMTP id
	n3K6ndan020802
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 15:49:39 +0900 (JST)
Received: by mail-gw.jp.panasonic.com (8.11.6p2/3.7W/somlb1) with ESMTP id
	n3K6ndT26763
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 15:49:39 +0900 (JST)
Received: from epochmail.jp.panasonic.com (localhost [127.0.0.1])
	by mail.jp.panasonic.com (8.11.6p2/3.7W/kc-maili05) with ESMTP id
	n3K6ncB18547
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 15:49:38 +0900 (JST)
Received: by epochmail.jp.panasonic.com (8.12.11.20060308/3.7W/somla1) id
	n3K6ndmT019665
	for linuxppc-dev@ozlabs.org; Mon, 20 Apr 2009 15:49:39 +0900 (JST)
Received: from [10.74.116.94]
	by somla1.jp.panasonic.com (8.12.11.20060308/3.7W) with ESMTP id
	n3K6ncN4019611
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 15:49:38 +0900 (JST)
Date: Mon, 20 Apr 2009 15:49:36 +0900
From: yamazaki seiji <yamazaki.seiji@kk.jp.panasonic.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: eth1 on nfsboot problem
Message-Id: <20090420153304.B8E7.YAMAZAKI.SEIJI@kk.jp.panasonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I am running the Linux kernel 2.6.28.7 on my PPC8347 BRD.
I have a problem.

nfsboot is succeeded,but eth1 fail to ifup like following message.

IP-Config: Complete:
     device=eth0, addr=192.168.0.131, mask=255.255.255.0, gw=192.168.0.1,
     host=mpc8347TPRO, domain=, nis-domain=(none),
     bootserver=192.168.0.123, rootserver=192.168.0.123, rootpath=
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
Looking up port of RPC 100003/2 on 192.168.0.123
PHY: 24520:01 - Link is Up - 100/Full
Looking up port of RPC 100005/1 on 192.168.0.123
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 184k init
INIT: version 2.86 booting
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...done.
Activating swap...done.
Remounting root filesystem...done.
mount: according to mtab, /dev/root is already mounted on /

Calculating module dependencies
Loading modules:
Starting checking all file systems: fsck
fsck 1.40 (29-Jun-2007)
Starting mounting local filesystems: mount /dev/mtdblock1 on /mnt/flash type jffs2 (rw)
/dev/mtdblock2 on /mnt/flash2 type jffs2 (rw)
umount.nfs: /dev/root: not found or not mounted
Setting up networking ....
/etc/network/options is deprecated.
Setting up IP spoofing protection: rp_filter done.
Disabling TCP/IP SYN cookies: done.
Disabling IPv4 packet forwarding: done.
Disabling TCP/IP Explicit Congestion Notification: done.
Starting network interfaces: SIOCADDRT: File exists
Failed to bring up eth0.
SIOCSIFADDR: No such device
eth1: ERROR while getting interface flags: No such device
SIOCSIFNETMASK: No such device
eth1: ERROR while getting interface flags: No such device
Failed to bring up eth1.
done.

but on ramboot,eth1 succeed to ifup.
What is the difference between nfsboot and ramboot?

-- 
yamazaki seiji <yamazaki.seiji@kk.jp.panasonic.com>
