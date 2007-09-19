Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CBC1ADDE3C
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 17:28:33 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 19 Sep 2007 09:28:31 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20070919072831.322800@gmx.net>
MIME-Version: 1.0
Subject: cuImage generation
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I tried to compile a 2.6.23-rc6 kernel yesterday, but wasn't able to get a
cuImage.<platform) out of it (only the uImage file was generated). My
platform config defines DEFAULT_UIMAGE and WANT_DEVICE_TREE. Do I need to
generate it manually or is there a makefile where I have to specify it?
Naturally I added my cuboot wrapper code to the arch/powerpc/boot/Makefile.

Thanks!

regards,

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
