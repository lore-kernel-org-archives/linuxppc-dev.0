Return-Path: <joe@perches.com>
Received: from mail.perches.com (136-022.dsl.LABridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 9406CDDF4B
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 06:48:18 +1100 (EST)
Subject: Re: [rtc-linux] Re: [PATCH 7/7] powerpc/ps3: Add rtc-ps3
From: Joe Perches <joe@perches.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <49B568D0.5000901@am.sony.com>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090309151216.17f13862@i1501.lan.towertech.it>
	<49B55A21.2010801@am.sony.com>
	<20090309194307.154f3e95@i1501.lan.towertech.it>
	<49B568D0.5000901@am.sony.com>
Content-Type: text/plain
Date: Mon, 09 Mar 2009 12:18:42 -0700
Message-Id: <1236626322.8307.9.camel@localhost>
Mime-Version: 1.0
Cc: linux-m68k@vger.kernel.org,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Geert.Uytterhoeven@sonycom.com, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-09 at 12:06 -0700, Geoff Levand wrote:
> There was some work by Joe Perches to list the files a maintainer is
> responsible for into the MAINTAINERS file.  I think that would give
> you what you want, a way to automatically get the maintainer of a
> file.
> 
> Joe, could you let us know the status of that work?

I think it works fine, and is an acceptable
approach to finding a maintainer for either a
patch or a specific file.

The changes I've posted are probably not suitable
for merging by anyone other than Linus as
MAINTAINERS is the most heavily modified file
in the kernel tree.

I've submitted it several times after merging it
with the latest kernel without response from Linus.

I'd merge and submit it again if it could be accepted.

If someone would propose a mechanism that would
improve the possibility to get it merged, I'd
also appreciate that.
