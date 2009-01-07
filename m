Return-Path: <wim@iguana.be>
Received: from mailrelay002.isp.belgacom.be (mailrelay002.isp.belgacom.be
	[195.238.6.175]) by ozlabs.org (Postfix) with ESMTP id DE74CDE7B9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 08:48:39 +1100 (EST)
Date: Wed, 7 Jan 2009 22:48:34 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] watchdog: Basic support for GE Fanuc's FPGA based
	watchdog timer
Message-ID: <20090107214834.GF11454@infomag.infomag.iguana.be>
References: <20081110123101.8608.352.stgit@ubuntu8041.localdomain>
	<20081110123125.8608.2251.stgit@ubuntu8041.localdomain>
	<A23D61BC-CA79-490C-8C70-F4341E7844EA@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A23D61BC-CA79-490C-8C70-F4341E7844EA@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Martyn Welch <martyn.welch@gefanuc.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

> Any status of acceptance of this?

I changed the ioctl to an unlocked ioctl and removed the temperature ioctl call.
It's now in my linux-2.6-watchdog-next tree. Can someone verify that it still works?
(http://git.kernel.org/?p=linux/kernel/git/wim/linux-2.6-watchdog-next.git;a=summary)

Kumar,

the second patch is also in. Do we keep in in the watchdog tree since it almost doesn't
touch the powerpc arch or do you want it in your tree?

Kind regards,
Wim.
