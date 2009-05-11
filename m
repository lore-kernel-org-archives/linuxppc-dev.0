Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id 19F6DDDDB2
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 00:58:22 +1000 (EST)
Received: by qyk29 with SMTP id 29so5095263qyk.17
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 07:58:20 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <4A07C664.6040609@dlasys.net>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
Date: Mon, 11 May 2009 09:58:20 -0500
Message-ID: <ed82fe3e0905110758l59ee1c94nffbfa50280851613@mail.gmail.com>
Subject: Re: device trees.
From: Timur Tabi <timur@freescale.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 11, 2009 at 1:32 AM, David H. Lynch Jr. <dhlii@dlasys.net> wrot=
e:
> =A0 =A0We are very actively headed in the opposite direction. It is my/ou=
r
> intention to have a single linux executable that works accross
> =A0 =A0everyone of our cards and everyone of our bitfiles.

This is the same direction that "we" are headed in as well.  For a
given core, it is more or less possible to generate one kernel that
works on any number of  SOCs and boards that use that core.  The only
difference is which device tree it is given.

So all you need to do is have your boot loader create a device tree
from scratch.  If you're using U-Boot, then you can already do this by
making the appropriate libfdt calls.  Otherwise, you should probably
add libfdt to your boot loader.

--=20
Timur Tabi
Linux kernel developer at Freescale
