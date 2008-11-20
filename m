Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AD09FDDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 02:42:48 +1100 (EST)
Date: Thu, 20 Nov 2008 16:20:54 +0100
From: Benjamin Krill <ben@codiert.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Add support for the nwp serial device
Message-ID: <20081120152054.GO24487@codiert.org>
References: <200811201501.24000.arnd@arndb.de>
	<20081120141345.GA2410@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20081120141345.GA2410@yoda.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh,

>What does 'NWP' stand for, and how is it different from a regular serial
>port?  Also, what platforms can this device be found on currently?
>
>Some of that should be included in the changelog, but I'm curious as well
>too.

NWP stands for network processor and it is part of the QPACE - Quantum
Chromodynamics Parallel Computing on the Cell Broadband Engine
project [1]. The implementation is a lightweight uart implementation
with the focus to consume as little resources as possible and it is
connected to a DCR bus.

 Ben
