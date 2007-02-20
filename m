Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 01723DDD09
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 02:59:33 +1100 (EST)
Date: Tue, 20 Feb 2007 19:00:11 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: enabling two eths
Message-ID: <20070220190011.09b6b8e6@vitb.dev.rtsoft.ru>
In-Reply-To: <45DB146A.7010302@cambridgebroadband.com>
References: <OFAEAB5385.D1B18D5F-ON65257288.0048394A-65257288.00493E72@lntemsys.com>
	<45DB146A.7010302@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org, Manjunath AM <Manjunath.AM@Lntemsys.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 20 Feb 2007 15:31:54 +0000
Alex Zeffertt <ajz@cambridgebroadband.com> wrote:

> 
> Manjunath AM wrote:
> > 
> > Hi,
> > 
> > We are using MPC8272 based target board, we use montavista Linux version 
> > 2.6.10 kernel image (with NFS enabled) to our target board,
> > 
> > Our board has  2 FCCs (eth0 and eth1). bot the eth's works perfectly 
> > when we use them independently, but when we are trying to enable second 
> > one after the kernel is up using linux command  "ifconfig eth1 
> > 192.168.33.64 up"(IP address)nothing is working.
> > Please suggest how to enable second eth (either 0 or 1) once the kernel 
> > is up with NFS file system
> 
> 
> Have you made sure that eth0 and eth1 are on *different* IP subnets?
> If they are on the same subnet, or intersecting subnets, your routing
> will get confused.
> 
It depends :)

I used to test functionality such a way to have two enets in same subnet, then ifdown one of them.

At least with mvista RFS, one enet  handles NFS, other is up but all the packets are routed to it via
the first one. And when the first one got ifdown, routing switches to the remaining enet...
-- 
Sincerely, 
Vitaly
