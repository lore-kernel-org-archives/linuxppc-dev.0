Return-Path: <diggskevin38@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C86EB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 10:52:37 +1100 (EST)
Received: by fxm6 with SMTP id 6so4848936fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 20 Mar 2011 16:52:32 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 20 Mar 2011 18:52:32 -0500
Message-ID: <AANLkTikRU9W61m7EcNONx9=Uinj-F7escWBCOTTdh==N@mail.gmail.com>
Subject: PowerMac7,3 dvd drive?
From: kevin diggs <diggskevin38@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am seeing ... issues with the optical drive (hda) under 2.6.36. I
can't mount disks:

[root@PowerMacG5 ~]# mount -r /dev/hda /mnt/cdrom
mount: /dev/hda already mounted or /mnt/cdrom busy

The log has:

[  239.922268] hda: irq timeout: status=0xd0 { Busy }
[  239.922485] hda: possibly failed opcode: 0xa0

eject hda will hang ... longer than my patience.

At first I thought the drive was going south. But I don't see this (at
least so far) on 2.6.28.

Thanks!

kevin
