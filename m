Return-Path: <mikpe@it.uu.se>
Received: from fanny.its.uu.se (fanny.its.uu.se [130.238.4.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 905CDB70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 18:16:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19877.23529.745123.819112@pilspetsen.it.uu.se>
Date: Wed, 13 Apr 2011 10:16:41 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
In-Reply-To: <1302652502.28876.76.camel@pasglop>
References: <19876.35918.322649.256455@pilspetsen.it.uu.se>
	<1302646173.28876.53.camel@pasglop>
	<1302652502.28876.76.camel@pasglop>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:
 > 
 > > > Finally I tried using g5_defconfig with 2.6.39-rc3.  First boot
 > > > it did get to /sbin/init, but udev init took much longer than
 > > > normal and threw errors.  After a warm reboot the same kernel
 > > > hung as usual, this time before framebuffer init.
 > > > 
 > > > 2.6.38 works just fine.
 > > 
 > > Hrm, that must be new, I remember testing something around -rc1 on a
 > > similar machine and it worked fine. I'll see if I can find something
 > > out.
 > 
 > Ok so on a PowerMac7,3 here (dual 2.5Ghz and mostly same HW or at least
 > very similar) I can't reproduce your problem with a g5_defconfig.
 > 
 > Your config doesn't work well for me (I don't do modules, I netboot),
 > but after adding a few things to it, it seems to work fine as well. I
 > added radeonfb and the radeon DRM (not KMS) and I added eventfd, timerfd
 > and input events.
 > 
 > So I'm afraid I'm going to need you to bisect that one to find out what
 > exact change caused the breakage for you.

Thanks for checking.  I'll try a bisect later today.

/Mikael
