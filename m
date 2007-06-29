Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 94D61DDE1B
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 00:34:17 +1000 (EST)
Date: Fri, 29 Jun 2007 16:34:14 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] dtc: Add install makefile target
Message-ID: <20070629143414.GA13053@aepfle.de>
References: <1183125374.30145.14.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1183125374.30145.14.camel@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 29, Josh Boyer wrote:

> +DESTDIR = /
> +BINDIR = usr/bin

+DESTDIR=
+BINDIR=/usr/bin

Just like every other package out there.
