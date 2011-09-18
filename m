Return-Path: <heitkamp@ameritech.net>
Received: from nm27-vm0.access.bullet.mail.mud.yahoo.com
	(nm27-vm0.access.bullet.mail.mud.yahoo.com [66.94.236.227])
	by ozlabs.org (Postfix) with SMTP id 1FBDD1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Sep 2011 05:21:54 +1000 (EST)
Message-ID: <4E7644C9.4070802@ameritech.net>
Date: Sun, 18 Sep 2011 15:21:45 -0400
From: "F. Heitkamp" <heitkamp@ameritech.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: mount file system using offset.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

First of all please accept my apologies for posting to this list on this 
particular topic, but it was the closest match I could find.

I pulled the harddisk out of my ps3, because I have forgotten the root 
password on the linux partition.

After spending some time googling I see that the harddisk is encrypted 
and there are no linux utilities that can read/write it.

However I did find that the "testdisk" program finds the linux 
partitions on the disk (see below.).

It seems I should be able to mount the partitions on my linux pc box 
somehow since I now know their location on the disk.

Does anyone know how one might go about that?

Thanks!

Fred

TestDisk 6.12, Data Recovery Utility, May 2011
Christophe GRENIER <grenier@cgsecurity.org>
http://www.cgsecurity.org

Disk /dev/sdc - 80 GB / 74 GiB - CHS 9729 255 63

The harddisk (80 GB / 74 GiB) seems too small! (< 13 TB / 11 TiB)
Check the harddisk size: HD jumpers settings, BIOS detection...

The following partition can't be recovered:
      Partition               Start        End    Size in sectors
 >  Linux SWAP 2          9675 127 42 1593896 192  5 25450514424


TestDisk 6.12, Data Recovery Utility, May 2011
Christophe GRENIER <grenier@cgsecurity.org>
http://www.cgsecurity.org

Disk /dev/sdc - 80 GB / 74 GiB - CHS 9729 255 63
      Partition               Start        End    Size in sectors
 >P ext3                  1566 128 42  1579 127 35     208776 [/boot]
  P ext3                  1579 127 42  9675 127 41  130062240 [/]
