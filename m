Return-Path: <johnny.hacking@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id 6A757B7C8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 20:20:55 +1100 (EST)
Received: by pwj11 with SMTP id 11so2541348pwj.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 01:20:53 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 19 Jan 2010 17:20:53 +0800
Message-ID: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
Subject: mount ramdisk rootfs /etc directory to jffs2 filesystem.
From: Johnny Hung <johnny.hacking@gmail.com>
To: linux-embedded@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org, kernelnewbies <kernelnewbies@nl.linux.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi ALL,

I have build an embedded Linux system and rootfs is a ramdisk. Ramdisk
rootfs resides in memory so modify files is non-effective after a
reboot. Some directories in rootfs, like /etc, /usr, ... are contain
many application configuration files and I want to mount it to jffs2
flash filesysyem so it will take effect after a reboot. Is it
possible? I know the flash has write times limited so the log files
(syslogd/klogd) should not store in flash. In general, how to deploy
root file system for embedded linux with flash storage?

H. Johnny
