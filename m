Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id F3D51E01C7
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:12:25 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: monstr@seznam.cz
Subject: Re: Microblaze init port v4
Date: Thu, 26 Jun 2008 17:09:36 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200806261709.37045.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, monstr@seznam.cz wrote:
> We have there still problem with syscalls and we don't have chance to 
> fix it to stable version, this is not part which I can do yourself. 
> Microblaze will be n + 1 platform which use some old syscalls. 
> I hope you understand.

That still leaves the problem that a lot of your syscalls have bugs
copied from other platforms. If you need to maintain backwards compatibility
with your existing binaries, that's fine, but please fix the code you are
adding.

	Arnd <><
