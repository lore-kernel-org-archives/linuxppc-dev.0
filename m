Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7984DE026
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 07:26:06 +1100 (EST)
Subject: Re: [PATCH 10/14] ps3: get firmware version
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45BA4DD5.2030106@am.sony.com>
References: <45B81891.1010309@am.sony.com> <20070126025955.GE18537@lst.de>
	<45BA4DD5.2030106@am.sony.com>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 07:25:38 +1100
Message-Id: <1169843138.24996.114.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Anyway, that is the need, the question is where to make it available.  I thought
> /proc/cpuinfo already has the platform type (coming from the generic powerpc
> code), so it would be convenient for utilities to have the firmware version
> there too.  I don't think parsing the dmsg is an option for minimal
> configs like bootloaders and distro installers, as they may not keep the boot
> messages around, and in general doesn't seem a reliable way.  If you can make
> a suggestion, I'd like to hear it.

Yeah, /proc/cpuinfo is actually a fairly convenient place for that...

Ben.
