Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id D238DDE152
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 02:41:22 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or
	redirect to asm-generic
Date: Thu, 26 Jun 2008 18:38:32 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<200806261735.12738.arnd@arndb.de>
	<20080626162118.GG22025@cs181140183.pp.htv.fi>
In-Reply-To: <20080626162118.GG22025@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200806261838.33787.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	monstr@seznam.cz, John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, Adrian Bunk wrote:
> The comment could be nuked (as well as the #ifdef __KERNEL__), but for 
> the one #define an asm-generic header would IMHO be overkill.

I agree that it doesn't technically make sense to have a one-line
asm-generic header, but I like the idea of reducing the number of
asm/*.h files that actually contain anything other that
#include <asm-generic/$FILE.h>, mostly for documentation purposes.

If we can eventually agree on a way to get rid of the requirement
for explicit redirection, we can remove a larger number of source
files completely.

	Arnd <><
