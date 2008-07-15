Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 24674DDED0
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 03:42:03 +1000 (EST)
Date: Tue, 15 Jul 2008 21:42:01 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: GPIO drivers, other patches?
Message-ID: <20080715174201.GA2231@polina.dev.rtsoft.ru>
References: <AB4393B8-8578-4AFA-B23A-048F86A9A24D@kernel.crashing.org>
	<20080715160048.GA31615@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080715160048.GA31615@polina.dev.rtsoft.ru>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 08:00:48PM +0400, Anton Vorontsov wrote:
> On Tue, Jul 15, 2008 at 10:10:21AM -0500, Kumar Gala wrote:
> > Anton,
> >
> > I think I've gotten most of the patches from you, 
> 
> Yes, much thanks!
> 
> > but I know there are  
> > few I've lost.  Can you just repost any patches that aren't in my  
> > powerpc-next tree.

While testing the tree in run-time found that this patch is missing:

[PATCH 3/4] powerpc: rtc_cmos_setup: assign interrupts only if there is i8259 PIC
http://patchwork.ozlabs.org/linuxppc/patch?id=18915

Without this patch rtc will fail to probe on MPC8610HPCD:

rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
rtc_cmos: probe of rtc_cmos failed with error -38


Did you deliberately hold off this patch, i.e. should I ask Benjamin
to take this through his tree?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
