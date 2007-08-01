Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id E53DEDDDE6
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 09:35:06 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: DTC 1.0.0 Release Coming?
Date: Thu, 2 Aug 2007 01:35:03 +0200
References: <E1IDjSy-0003eC-T4@jdl.com>
In-Reply-To: <E1IDjSy-0003eC-T4@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708020135.03477.arnd@arndb.de>
Cc: Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 25 July 2007, Jon Loeliger wrote:
> I'd like to make an official DTC Version 1.0.0 release soon!
> To that end, I've published a repo on jdl.com with a v1.0.0-rc1
> tag on it. =A0I anticipate some updates to the Documentation before
> a final 1.0.0 release still. =A0However, if you have something
> you would like to have be in The Real 1.0.0 release, please
> let me know soon!

A  bug has been reported in both fedora and debian about /usr/bin/ftdump
conflicting with a file of the same name in freetype.

Can we rename the binary in dtc to avoid this? Maybe /usr/bin/dtc-ftdump
would be better.

	Arnd <><

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D434890
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D249638
