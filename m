Return-Path: <jwboyer@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0D6C6B7B77
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 21:05:55 +1000 (EST)
Received: from mail-yw0-f185.google.com (mail-yw0-f185.google.com
	[209.85.211.185]) by ozlabs.org (Postfix) with ESMTP id 6A698DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 21:05:52 +1000 (EST)
Received: by ywh15 with SMTP id 15so1140957ywh.10
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 04:05:50 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 27 Aug 2009 07:05:45 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20090827110545.GJ5387@hansolo.jdub.homelinux.org>
References: <1251344028.20467.8.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1251344028.20467.8.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 27, 2009 at 01:33:48PM +1000, Benjamin Herrenschmidt wrote:
>Hi Linus !
>
>Here are a couple of last minute patches for 2.6.31. One is a regression fix
>(afaik) where a PS3 driver gets incorrectly loaded on other platforms and
>crashes, along with a PS3 defconfig update.
>The following changes since commit f415c413f458837bd0c27086b79aca889f9435e4:
>  Linus Torvalds (1):
>        Merge git://git.kernel.org/.../davem/net-2.6
>
>are available in the git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
>
>Geert Uytterhoeven (1):
>      powerpc/ps3: Add missing check for PS3 to rtc-ps3 platform device registration
>
>Geoff Levand (1):
>      powerpc/ps3: Update ps3_defconfig

Hm.  No 44x flush_icache_range patch?

josh
