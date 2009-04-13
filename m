Return-Path: <srostedt@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id C1A38DDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 01:52:04 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc, Makefile: Make it possible to safely
	select CONFIG_FRAME_POINTER
From: Steven Rostedt <srostedt@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20090405210756.GG24374@uranus.ravnborg.org>
References: <20090320164404.GA19933@oksana.dev.rtsoft.ru>
	<20090320164429.GA28037@oksana.dev.rtsoft.ru>
	<20090405210756.GG24374@uranus.ravnborg.org>
Content-Type: text/plain
Date: Mon, 13 Apr 2009 11:51:25 -0400
Message-Id: <1239637885.21121.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2009-04-05 at 23:07 +0200, Sam Ravnborg wrote:

> 4) The individual "HAVE_* members should be sorted alphabetically in the arch
>    Kconfig file (which they seldomly are :-( )

Note, my first port of Ftrace to PPC sorted the Kconfig HAVE_* macros,
which ended up being reverted :-/

http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21222.html

As stated, I did the sort without reporting the change in the
change-log, which I should have done.

-- Steve
