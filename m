Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 3BC182BE83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 00:14:10 +1100 (EST)
Message-ID: <1102944779.41bd9a0b9155f@webmail.televes.com:443>
Date: Mon, 13 Dec 2004 14:32:59 +0100
From: alebas@televes.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: depmod.pl script & kernel 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

Till now I've been using the ELDK 3.0 framework for development.
Now I am involved in some development on kernel 2.6, and I would
prefer using kernel modules. But I can't get script depmod.pl in
eldk/usr/sbin working with kernel 2.6 modules.

I've checked for a new version of this script on Busybox (I think
it's the same than ELDK's one), but since version 1.0 this is not
available.

So, how are you coping with this? Is there any way to use ELDK
with kernel 2.6 modules? Or should I change to another framework?

Currently, I work with ELDK on an i686 system, cross-compiling
onto PPC with the ppc_82xx- toolchain included in the ELDK.
I use the SELF's RamFS from the ELDK, with Busybox shell and
modutils. The depmod.pl script creates the modules.dep file
in this rootfs.

Thanks,

Alex
