Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] zImage: Cleanup and improve zImage entry point
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45D9BEC0.1060909@am.sony.com>
References: <20070216062739.6DFDBDDD05@ozlabs.org>
	<45D7AA50.3090408@am.sony.com>
	<20070218072310.GB1859@localhost.localdomain>
	<45D9BEC0.1060909@am.sony.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 06:59:40 +1100
Message-Id: <1171915180.18571.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I think the better idea is to make the generic bootwrapper code support
> SMP.  I don't see any fundamental reason why it can't.  The trouble here
> is that your BSS stack is really not a proper way, that's why it doesn't
> work.
> 
> I'll put something together that provides generic (SMP) stack support
> for the bootwrapper.  I'll  be away the end of this week and next week,
> so I don't know when I'll be able to post it.

As I said earlier, I see no reason why the wrapper needs to provide a
stack for non-primary CPUs.

Ben.
