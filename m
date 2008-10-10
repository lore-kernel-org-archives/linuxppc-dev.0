Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 43671DEAC7
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 02:59:08 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/5] powerpc/40x: Add support for PowerPC 405EZ Acadia
	board
Date: Fri, 10 Oct 2008 17:58:54 +0200
References: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
	<071a0947286c71852506d8d5c63cc9c88d5f4191.1223642006.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <071a0947286c71852506d8d5c63cc9c88d5f4191.1223642006.git.jwboyer@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810101758.54939.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 04 September 2008, Josh Boyer wrote:

>  arch/powerpc/platforms/40x/Kconfig  |   14 +++++++++
>  arch/powerpc/platforms/40x/Makefile |    1 +
>  arch/powerpc/platforms/40x/acadia.c |   56 +++++++++++++++++++++++++++++++++++

acadia.c is 99% identical malaku.c and kilauea.c, right?

Wouldn't this be a good moment to start the ppc405_simple platform like
you have for 440?

	Arnd <><
