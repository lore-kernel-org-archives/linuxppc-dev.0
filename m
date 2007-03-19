Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 1BC97DDF12
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 11:34:35 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Fedora Core 6 or 7 on PPC?
Date: Mon, 19 Mar 2007 01:34:25 +0100
References: <20070319001739.DE91135260B@atlas.denx.de>
In-Reply-To: <20070319001739.DE91135260B@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703190134.26030.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 19 March 2007, Wolfgang Denk wrote:
> has anybody Fedora Core 6 (or even better FC7 - test) running on a PPC
> system? Could you please send me the /root/install.log file from your
> system? I'd like to know which packages get installed by default, and
> in which order.

I don't have an up-to-date version of it right here, but in case you
are trying to do an installation of the minimal rpm files from a
running system, I can recommend the following procedure:

rpm --root /fc7/ --initdb
rpm --root /fc7/ -ivh --nodeps ftp://ftp-stud.fht-esslingen.de/Mirrors/fedora.redhat.com/linux/core/development/ppc/os/Fedora/fedora-release-*.noarch.rpm
yum --installroot=/fc7/ -y groupinstall Base

	Arnd <><
