Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 990C51007D1
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 09:32:54 +1100 (EST)
Date: Sat, 28 Nov 2009 01:32:51 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 0/8 userland!] systemtap: Add initial support for ppc32
Message-ID: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Here are some patches that add systemtap support for ppc32 machines.

This is all pretty straightforward, though I didn't test it much,
only run few 'hello world' taps and decided that it's good enough. ;-)

I plan to test it more thoughtfully sometime next week, and fix missing
things (if any). But so far I'm interested in the feedback on this
initial support.

Thanks!

p.s. I though it would be a good idea to cc linuxppc-dev. At least
kexec-tools guys tend to do it as well.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
