Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id C3F592BDF2
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Dec 2004 10:16:23 +1100 (EST)
Date: Thu, 2 Dec 2004 16:16:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Corey Minyard <minyard@acm.org>
Message-ID: <20041202231621.GF14005@smtp.west.cox.net>
References: <41AF7DFC.9040009@acm.org>
	<20041202222349.GE14005@smtp.west.cox.net>
	<20041202154901.B20211@home.com> <41AF9E25.2080109@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41AF9E25.2080109@acm.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PPC debug setcontext  syscall implementation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 02, 2004 at 04:58:45PM -0600, Corey Minyard wrote:

> I'll test gdb on classic and an ebony that I have.  I assume that gdb 
> has a built-in test suite?

The GDB sources, yes.  You do need to build GDB first, have dejagnu
installed and then run a 'make check'.  Ping me off-list if you want
some help getting it all done.

-- 
Tom Rini
http://gate.crashing.org/~trini/
