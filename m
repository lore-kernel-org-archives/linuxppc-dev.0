Return-Path: <krautilein@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DF21DB7CF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 23:57:26 +1100 (EST)
Date: Thu, 1 Apr 2010 14:56:42 +0200
From: Bolko Maass <krautilein@gmx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: poweroff/suspend problems on PowerMac G5
Message-Id: <20100401145642.70d5eab0.krautilein@gmx.de>
In-Reply-To: <alpine.DEB.2.01.1003311131250.5493@bogon.housecafe.de>
References: <alpine.DEB.2.01.1003310430570.5493@bogon.housecafe.de>
	<20100331132300.GA15951@oksana.dev.rtsoft.ru>
	<alpine.DEB.2.01.1003311131250.5493@bogon.housecafe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi everybody!

Hope this list is even the right place to bring this up, but I've exhausted everything else I could think of, so here it goes.

The problem is that my PowerMac G5 Quad machine ("PowerMac 11,2", Gentoo, linux-2.6.34-rc2) will not power down if suspend infrastructure (CONFIG_HIBERNATION) is in the kernel. It will stop all services and halt, but never power down. This is when actually trying to suspend as well as when just trying to shut down the machine. Reboot works fine, so I suspect that the kernel doesn't actually crash.

At least one other person on the #gentoo-powerpc channel on freenode has reported the same problem and that unsetting CONFIG_HIBERNATION will fix it.

Please advise on how to debug something like this, as this is really beyond my expertise.

Thanks!
