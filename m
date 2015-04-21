Return-Path: <larrystotler@netscape.net>
Received: from omr-m01.mx.aol.com (omr-m01.mx.aol.com [64.12.143.75])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 327971A0028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 10:48:34 +1000 (AEST)
Date: Mon, 20 Apr 2015 20:43:24 -0400
From: larrystotler@netscape.net
To: wsa@the-dreams.de, linuxppc-dev@lists.ozlabs.org
Message-Id: <14cd96df76d-41ad-451c9@webprd-m95.mail.aol.com>
In-Reply-To: <20150416135014.GE913@katana>
References: <20150416135014.GE913@katana>
Subject: Re: [opensuse-ppc] HELP: test kernel patches on the real thing
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----Original Message-----
From: Wolfram Sang <wsa@the-dreams.de>
 
Quoted from the opensuse-ppc mailing list

>I'm Wolfram Sang, maintainer of the I2C subsystem of the Linux Kernel. I
>want to get rid of an ancient mechanism in the I2C core which was used in the
>2.4 era. There are only two users left; drivers for old Macintosh computers I
>don't have access to. So, I tried to emulate the behaviour on an ARM board and
>wrote a replacement for the old mechanism which works fine here. Now, I wonder
>if there are people willing to test these patches on the real thing? This would
>be much appreciated!

I have a bunch of older macs but none currently has linux and/or a current version of linux on them.  

What models do you need tested?  Can you point me to a quick easy to install distro?  I usually use openSUSE but I think Fedora has a ppc port now as well.

I only have 32bit macs.  I have:

iMac DV 400Mhz
PowerMac G4 Digital Audio 466Mhz
2 - PowerMac G3 Blue & Whites (one with a G4 I THINK).
PowerMac 9600
PowerMac 9500
PowerMac 6500
PowerMac 6400
PowerMac G3 All In One Beige.
PowerBook G3 Wallstreet

I probably have more.  The top 4 are New World, the rest are Old World.  Not even sure if they work anymore but I can try them if you want.

I'm not a programmer, so if you could offer me some simple steps to adding the patches to the kernel I would be able to help.

Thanx
