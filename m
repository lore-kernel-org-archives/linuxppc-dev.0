Return-Path: <sr@denx.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id 107536830E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 01:06:45 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Matt Porter <mporter@kernel.crashing.org>
Date: Mon, 19 Sep 2005 17:06:23 +0200
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509191302.15462.sr@denx.de> <20050919065942.A25356@cox.net>
In-Reply-To: <20050919065942.A25356@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509191706.24298.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: cleanup AMCC PPC4xx eval boards to better
	support U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matt,

On Monday 19 September 2005 15:59, Matt Porter wrote:
> On Mon, Sep 19, 2005 at 01:02:14PM +0200, Stefan Roese wrote:
> > Just to be sure: The 44x boot-wrapper approach you mention is
> > "boot/simple/pibs.c"?
>
> Yes, there's both boot/simple/pibs.c and boot/simple/openbios.c that
> were created so we could have the default firmware and u-boot use the
> same kernel build.

Yes, that's what I thought. But Eugene mentioned, that he boots vmlinux 
without any boot-wrapper on the OpenBIOS targets (except Ebony probably). You 
would loose this possibility, if I add this wrapper and switch from OpenBIOS 
to U-Boot bd_info struct in the kernel.

Did I miss something here? How should I proceed?

Best regards,
Stefan
