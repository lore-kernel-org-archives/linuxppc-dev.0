Return-Path: <srostedt@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 2B942DDE1F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 11:36:22 +1100 (EST)
Subject: Re: [PATCH 2/3] powerpc: Make it possible to safely select
	CONFIG_FRAME_POINTER
From: Steven Rostedt <srostedt@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1233793889.4612.33.camel@pasglop>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150838.GB30027@oksana.dev.rtsoft.ru>
	<1233793889.4612.33.camel@pasglop>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 19:35:54 -0500
Message-Id: <1233794154.16878.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2009-02-05 at 11:31 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2009-02-04 at 18:08 +0300, Anton Vorontsov wrote:
> > Remove -fno-omit-frame-pointer flag from CFLAGS.
> > Remove -fno-omit-frame-pointer workarounds.
> 
> But what about -pg -requires -fno-omit-frame-pointer ?

I don't think it requires -fno-omit-frame-pointer. It is just
incompatible with -fomit-frame-pointer.

-- Steve
