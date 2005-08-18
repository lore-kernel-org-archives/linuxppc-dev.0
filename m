Return-Path: <Tony_Hardie@net.com>
Received: from mx02.net.com (mx02.net.com [134.56.3.132])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E350A67F92
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 09:42:03 +1000 (EST)
Received: from mx01-int.net.com (mx01-int.net.com [134.56.112.13])
	by mx02.net.com (Switch-3.1.3/Switch-3.1.0) with ESMTP id
	j7INPYTL009666 for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 16:25:34 -0700 (PDT)
Received: from fmt-ex01.net.com (fmt-exchange.net.com [134.56.112.251])
	by mx01-int.net.com (Switch-3.1.3/Switch-3.1.0) with ESMTP id
	j7INIFOO013386 for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 16:18:17 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Thu, 18 Aug 2005 16:22:22 -0700
Message-ID: <CE711B0E5D7A1A4096A808997E00832982A42A@fmt-ex01.net.com>
From: "Tony Hardie" <Tony_Hardie@net.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: jffs2 image upgrade on running root
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Guys,
I have a running embedded 2.6.11 distro with a busybox type jffs2 rfs.
Not I am trying to upgrade that jffs2 imaged and tried something like to
following.

Have a temp ext2 ramdisk mounted in /mnt
pivot_root . oldroot
exec chroot . /linuxrc <dev/console >dev/console 2>&1
or
exec chroot . /sbin/init <dev/console >dev/console 2>&1

all "seem" to work bit init is still running I think on the /oldroot/ as
well so when I try to umount /oldroot is just get  device or resource
busy.
Any ideas?


Tony Hardie B.Sc
SHOUTIP Software Architect
Net.com
6900 Paseo Padre Parkway
Fremont
CA, 94555
Ph: 510-574-2386
Mob: 510-449-4339
