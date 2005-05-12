Return-Path: <matej.kupljen@ultra.si>
Received: from deliver-1.mx.triera.net (deliver-1.mx.triera.net [213.161.0.31])
	by ozlabs.org (Postfix) with ESMTP id BC63B67A33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 20:20:10 +1000 (EST)
From: Matej Kupljen <matej.kupljen@ultra.si>
To: Peter Gehirnforce <Gehirnmann@gmx.de>
In-Reply-To: <25101.1115889218@www45.gmx.net>
References: <20050512074615.30BE8C1512@atlas.denx.de>
	<25101.1115889218@www45.gmx.net>
Content-Type: text/plain
Date: Thu, 12 May 2005 11:12:45 +0200
Message-Id: <1115889165.9703.9.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK/DENX: doesn't find iostream-lib when linking
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

> compiler = ${CROSS_COMPILE}gcc
>
> .... <snip>
>
> The program itself is using <string> <iostream> and other STL libs with
> namespaces in use.

Change the gcc to g++ if you use STL and C++ programs.

BR,
Matej
