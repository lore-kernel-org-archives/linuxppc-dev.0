Return-Path: <brenohl@br.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrr8q2n8JzDrR9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:37:27 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5JCZKSq045537
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 08:37:25 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b6chcfhgk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 08:37:25 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brenohl@br.ibm.com>;
 Mon, 19 Jun 2017 08:37:23 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5JCbLNn41222398
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 12:37:21 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C2E4AE051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 08:37:21 -0400 (EDT)
Received: from [9.85.150.174] (unknown [9.85.150.174])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 4CB16AE03C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 08:37:20 -0400 (EDT)
Subject: Debian 9 "Stretch" released
References: <20170618062236.GA25488@pryan.ekaia.org>
To: linuxppc-dev@lists.ozlabs.org
From: Breno Leitao <brenohl@br.ibm.com>
Date: Mon, 19 Jun 2017 09:37:19 -0300
MIME-Version: 1.0
In-Reply-To: <20170618062236.GA25488@pryan.ekaia.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <35640724-2a25-20fe-04f0-0472d56f0eb3@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Forwarded Message --------
Subject: Debian 9 "Stretch" released
Resent-Date: Sun, 18 Jun 2017 06:26:39 +0000 (UTC)
Resent-From: debian-announce@lists.debian.org
Date: Sat, 17 Jun 2017 20:22:36 -1000
From: Ana Guerrero Lopez <ana@debian.org>
To: debian-announce@lists.debian.org

------------------------------------------------------------------------
The Debian Project                               https://www.debian.org/
Debian 9 "Stretch" released                             press@debian.org
June 17th, 2017                https://www.debian.org/News/2017/20170617
------------------------------------------------------------------------


After 26 months of development the Debian project is proud to present
its new stable version 9 (code name "Stretch"), which will be supported
for the next 5 years thanks to the combined work of the Debian Security
team [1] and of the Debian Long Term Support [2] team.

    1: https://security-team.debian.org/
    2: https://wiki.debian.org/LTS

Debian 9 is dedicated [3] to the project's founder Ian Murdock, who
passed away on 28 December 2015.

    3: http://ftp.debian.org/debian/doc/dedication/dedication-9.0.txt

In "Stretch", the default MySQL variant is now MariaDB. The replacement
of packages for MySQL 5.5 or 5.6 by the MariaDB 10.1 variant will happen
automatically upon upgrade.

Firefox and Thunderbird return to Debian with the release of "Stretch",
and replace their debranded versions Iceweasel and Icedove, which were
present in the archive for more than 10 years.

Thanks to the Reproducible Builds project, over 90% of the source
packages included in Debian 9 will build bit-for-bit identical binary
packages. This is an important verification feature which protects users
from malicious attempts to tamper with compilers and build networks.
Future Debian releases will include tools and metadata so that end-users
can validate the provenance of packages within the archive.

Administrators and those in security-sensitive environments can be
comforted in the knowledge that the X display system no longer requires
"root" privileges to run.

The "Stretch" release is the first version of Debian to feature the
"modern" branch of GnuPG in the "gnupg" package. This brings with it
elliptic curve cryptography, better defaults, a more modular
architecture, and improved smartcard support. We will continue to supply
the "classic" branch of GnuPG as gnupg1 for people who need it, but it
is now deprecated.

Debug packages are easier to obtain and use in Debian 9 "Stretch". A new
"dbg-sym" repository can be added to the APT source list to provide
debug symbols automatically for many packages.

The UEFI ("Unified Extensible Firmware Interface") support first
introduced in "Wheezy" continues to be greatly improved in "Stretch",
and also supports installing on 32-bit UEFI firmware with a 64-bit
kernel. The Debian live images now include support for UEFI booting as a
new feature, too.

This release includes numerous updated software packages, such as:

  * Apache 2.4.25
  * Asterisk 13.14.1
  * Chromium 59.0.3071.86
  * Firefox 45.9 (in the firefox-esr package)
  * GIMP 2.8.18
  * an updated version of the GNOME desktop environment 3.22
  * GNU Compiler Collection 6.3
  * GnuPG 2.1
  * Golang 1.7
  * KDE Frameworks 5.28, KDE Plasma 5.8, and KDE Applications 16.08 and 16.04
for PIM components
  * LibreOffice 5.2
  * Linux 4.9
  * MariaDB 10.1
  * MATE 1.16
  * OpenJDK 8
  * Perl 5.24
  * PHP 7.0
  * PostgreSQL 9.6
  * Python 2.7.13 and 3.5.3
  * Ruby 2.3
  * Samba 4.5
  * systemd 232
  * Thunderbird 45.8
  * Tomcat 8.5
  * Xen Hypervisor
  * the Xfce 4.12 desktop environment
  * more than 51,000 other ready-to-use software packages, built from a bit
more of 25,000 source packages.

With this broad selection of packages and its traditional wide
architecture support, Debian once again stays true to its goal of being
the universal operating system. It is suitable for many different use
cases: from desktop systems to netbooks; from development servers to
cluster systems; and for database, web, or storage servers. At the same
time, additional quality assurance efforts like automatic installation
and upgrade tests for all packages in Debian's archive ensure that
"Stretch" fulfills the high expectations that users have of a stable
Debian release.

A total of ten architectures are supported: 64-bit PC / Intel EM64T /
x86-64 (amd64), 32-bit PC / Intel IA-32 (i386), 64-bit little-endian
Motorola/IBM PowerPC (ppc64el), 64-bit IBM S/390 (s390x), for ARM, armel
and armhf for older and more recent 32-bit hardware, plus arm64 for the
64-bit "AArch64" architecture, and for MIPS, in addition to the two 32-
bit mips (big-endian) and mipsel (little-endian), there is a new
mips64el architecture for 64-bit little-endian hardware. Support for 32-
bit Motorola/IBM PowerPC (powerpc) has been removed in "Stretch".

If you simply want to try Debian 9 "Stretch" without installing it, you
can use one of the available live images which loads and runs the
complete operating system in a read-only state via your computer's
memory. Should you enjoy the operating system you have the option of
installing from the live image onto your computer's hard disk. The live
image is available for CDs, USB sticks, and netboot setups. Initially,
these images are provided for the amd64 and i386 architectures only.
More information is available in the live install images section of the
Debian website [4].

    4: https://www.debian.org/CD/live/

Should you choose to install Debian 9 "Stretch" directly onto your
computer's hard disk you can choose from a variety of installation media
such as Blu-ray Disc, DVD, CD, USB stick, or via internal network.
Several desktop environments — GNOME, KDE Plasma Desktop and
Applications, LXDE, and Xfce — may be installed through those images
with your desired selection chosen from the boot menus of the install
media. In addition, multi-architecture CDs and DVDs are available which
support installation of multiple architectures from a single disc. Or
you can always create bootable USB installation media (see the
Installation Guide [5] for more details). For cloud users Debian also
offers pre-built OpenStack images [6] for amd64 and arm64 architectures,
ready to use.

    5: https://www.debian.org/releases/stretch/installmanual
    6: http://cdimage.debian.org/cdimage/openstack/current/

Debian can now be installed in 75 languages, with most of them available
in both text-based and graphical user interfaces.

The installation images may be downloaded right now via bittorrent [7]
(the recommended method), jigdo [8], or HTTP [9]; see Debian on CDs [10]
for further information. "Stretch" will soon be available on physical
DVD, CD-ROM, and Blu-ray Discs from numerous vendors [11] too.

    7: https://www.debian.org/CD/torrent-cd/
    8: https://www.debian.org/CD/jigdo-cd/#which
    9: https://www.debian.org/CD/http-ftp/
   10: https://www.debian.org/CD/
   11: https://www.debian.org/CD/vendors

Upgrades to Debian 9 from the previous release, Debian 8 (codenamed
"Jessie"), are automatically handled by the apt-get package management
tool for most configurations. As always, Debian systems may be upgraded
painlessly, in place, without any forced downtime, but it is strongly
recommended to read the release notes [12] as well as the installation
guide [13] for possible issues, and for detailed instructions on
installing and upgrading. The release notes will be further improved and
translated to additional languages in the weeks after the release.

   12: https://www.debian.org/releases/stretch/releasenotes
   13: https://www.debian.org/releases/stretch/installmanual


About Debian
------------

Debian is a free operating system, developed by thousands of volunteers
from all over the world who collaborate via the Internet. The Debian
project's key strengths are its volunteer base, its dedication to the
Debian Social Contract and Free Software, and its commitment to provide
the best operating system possible. This new release is another
important step in that direction.


Contact Information
-------------------

For further information, please visit the Debian web pages at
https://www.debian.org/ or send mail to <press@debian.org>.
