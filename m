Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 781DADDE47
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2008 16:48:10 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Could the DTS experts look at this?
Date: Sun, 10 Feb 2008 06:47:56 +0100
References: <47ACE630.8090101@pikatech.com>
In-Reply-To: <47ACE630.8090101@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802100647.56590.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 09 February 2008, Sean MacLennan wrote:
> If anybody has suggestions on better ways to do this, fire away.

I guess the cleanest solution would be to include two complete device trees
for this platform, and then choose the correct one in cuboot-warp.c based
on the board revision.

The obvious disadvantage of this is that you'd get two device trees
that you need to keep in sync with every change, so it might not
be very practical.

Maybe we can introduce a more generic way of having conditional
device nodes in the tree that get knocked out in the boot wrapper.

	Arnd <><
