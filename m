Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0513067EFB
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 00:28:30 +1000 (EST)
Date: Wed, 28 Jun 2006 16:21:42 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: backlight control broken in current Linus' and Paulus' trees
Message-ID: <20060628142142.GA12278@hansmi.ch>
References: <20060628133453.GA14876@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060628133453.GA14876@cathedrallabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello

On Wed, Jun 28, 2006 at 10:34:53AM -0300, Aristeu Sergio Rozanski Filho wro=
te:
> 	the backlight control is broken in my PowerBook6,8 in latest git
> 	trees, both for pbbuttonsd (yes, I have CONFIG_PMAC_BACKLIGHT_LEGACY
> 	enabled) and for fblevel. the last one also allows values be set
> 	at least to 1000 and according to new code, it should be able to
> 	reach 127.

Legacy will stay 0-15, because that's what legacy is about. To use the
new interface, you have to use the sysfs interface.

I've submitted another patch for legacy support last night which is now
waiting for Linus to include it. Do you want me to send it to you
directly or do you want to wait until it's in the git kernels?

Greets,
Michael

--=20
Gentoo Linux developer, http://hansmi.ch/, http://forkbomb.ch/
< doogie> asuffield: how do you think dpkg was originally written?  :|
< asuffield> by letting iwj get dangerously near a computer
    	-- in #debian-devel
