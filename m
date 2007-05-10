Return-Path: <bwarren@qstreams.com>
Received: from smtp110.biz.mail.re2.yahoo.com (smtp110.biz.mail.re2.yahoo.com
	[206.190.53.9]) by ozlabs.org (Postfix) with SMTP id E2027DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 May 2007 03:14:10 +1000 (EST)
Subject: Re: 83xx: requesting external interrupts
From: Ben Warren <bwarren@qstreams.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
In-Reply-To: <46434C1E.3020004@cambridgebroadband.com>
References: <46434C1E.3020004@cambridgebroadband.com>
Content-Type: text/plain
Date: Thu, 10 May 2007 13:07:27 -0400
Message-Id: <1178816847.9018.2.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex,

Follow this thread...
http://marc.info/?l=linuxppc-embedded&m=116849062702002&w=2

On Thu, 2007-05-10 at 17:45 +0100, Alex Zeffertt wrote:
> Hi list,
> 
> I'm trying to port a driver from 2.6.11 to 2.6.21 and I'm stuck on the following line:
> 
> 	request_irq(MPC83xx_IRQ_EXT5, mpc832xemds_phy_interrupt, SA_SHIRQ, "pm5384", dev);
> 
> The first problem is that MPC83xx_IRQ_EXT5 is no longer defined.  If I hard code this to
> what I think is the right value (i.e. 21) then request_irq fails on insmod.
> 
> I obviously need to do something different now that ARCH=powerpc, but I can't find any
> examples of code which requests 83xx external interrupts.  Can anybody help?
> 
> TIA,
> 
> Alex
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
