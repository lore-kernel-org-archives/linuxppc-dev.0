Return-Path: <fabo@debian.org>
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by ozlabs.org (Postfix) with ESMTP id 03F64DDE39
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 20:12:40 +1100 (EST)
From: Fathi Boudra <fabo@debian.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [dtc] breaking out libfdt from dtc so other progs can use it
Date: Sat, 1 Mar 2008 10:12:36 +0100
References: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>
	<20080228125940.78f7f2b6@vader.jdub.homelinux.org>
	<Pine.LNX.4.64.0802290930020.25557@vixen.sonytel.be>
In-Reply-To: <Pine.LNX.4.64.0802290930020.25557@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803011012.36876.fabo@debian.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think people are confusing source and binary packages.
>
> E.g. on Debian, the openssl source package is used to build 3 binary
> packages: openssl, libssl0.9.8, and libssl-dev. Hence to install
> applications that use libssl, you don't have to install all 3, just
> libssl0.9.8.

That make sense.
Just ask downstream (distros) to ship libfdt binaries packages.

cheers,

Fathi
