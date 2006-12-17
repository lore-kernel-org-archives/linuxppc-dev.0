Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 542CC67BF2
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 10:04:49 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/3] uevents handler for macio & of_platform
Date: Mon, 18 Dec 2006 00:04:44 +0100
References: <11663742771972-git-send-email-tnt@246tNt.com>
In-Reply-To: <11663742771972-git-send-email-tnt@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612180004.44933.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 17 December 2006 17:51, Sylvain Munaut wrote:
> The of_platform one has been tested on Efika and enable module
> autoloading by udev. The macio patch is not tested. However,
> being based on the same code as the of_platform handler I would
> excpect it to be fine.

Would it be possible to have only a single copy of that code,
for all of_device probes? I guess the same code also will be
used on ibmebus and the ps3platform bus eventually.

	Arnd <><
