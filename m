Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 46F17B71E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 09:25:23 +1000 (EST)
MIME-Version: 1.0
Date: Fri, 12 Jun 2009 19:25:20 -0400
Message-ID: <9e4733910906121625p68d1fbcdyd12b110248a3ac9d@mail.gmail.com>
Subject: build failure in PPC mpc5200_psc_ac97
From: Jon Smirl <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new driver for AC97 on the mpc5200 has landed in front of Timur's
patch implementing spin_event_timeout().  Timur's patch is in
powerpc-next which hasn't been merged yet. mpc5200_psc_ac97 will build
ok after this merge happens.

-- 
Jon Smirl
jonsmirl@gmail.com
