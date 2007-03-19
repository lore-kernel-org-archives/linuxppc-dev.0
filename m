Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0F0ABDDF35
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 05:44:48 +1100 (EST)
Message-ID: <45FEDA19.2060506@am.sony.com>
Date: Mon, 19 Mar 2007 11:44:41 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Fedora Core 6 or 7 on PPC?
References: <20070319001739.DE91135260B@atlas.denx.de>
	<200703190134.26030.arnd@arndb.de>
In-Reply-To: <200703190134.26030.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Monday 19 March 2007, Wolfgang Denk wrote:
>> has anybody Fedora Core 6 (or even better FC7 - test) running on a PPC
>> system? Could you please send me the /root/install.log file from your
>> system? I'd like to know which packages get installed by default, and
>> in which order.
> 
> I don't have an up-to-date version of it right here, but in case you
> are trying to do an installation of the minimal rpm files from a
> running system, I can recommend the following procedure:
> 
> rpm --root /fc7/ --initdb
> rpm --root /fc7/ -ivh --nodeps ftp://ftp-stud.fht-esslingen.de/Mirrors/fedora.redhat.com/linux/core/development/ppc/os/Fedora/fedora-release-*.noarch.rpm
> yum --installroot=/fc7/ -y groupinstall Base
> 

needed this...

mkdir -p /fc7/var/lib/rpm
mkdir -p /fc7/var/lib/tmp
mkdir -p /fc7/var/log
