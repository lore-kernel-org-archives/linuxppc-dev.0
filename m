Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id D25DFDDE2C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 01:17:02 +1100 (EST)
Date: Wed, 20 Dec 2006 08:16:55 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: 2 CPUs, but only one is used
Message-ID: <20061220141655.GJ15713@localdomain>
References: <20061217144127.579f01f0.pochini@shiny.it>
	<20061220003545.7053b05c.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061220003545.7053b05c.pochini@shiny.it>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Giuliano Pochini wrote:
> On Sun, 17 Dec 2006 14:41:27 +0100
> Giuliano Pochini <pochini@shiny.it> wrote:
> 
> > I have a dual G4 MDD mac running linux 2.6.19. When I boot with maxcpus=1 and
> > then I issue "echo 1 >/sys/devices/system/cpu/cpu1/online" the second CPU is
> > put online without errors, but it stays idle+wait=100% and of course
> > user+system+nice=0%. It works fine without maxcpus=1. No problems with 2.6.18.
> >
> > I saw that there are some cpu hotplug related changes in 2.6.19, but I have
> > no access to a non-ppc dual cpu box to check if the problem also affects
> > other architectures right now.
> 
> I tried to reproduce the problem on an intel box, but I couldn't. /sys
> contains only the cpu0 file if it boots with maxcpus=1.

Can you try to git bisect to find the change which caused the
regression?
