Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 05E4CDE11B
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 03:00:17 +1000 (EST)
Date: Fri, 25 Apr 2008 21:00:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/6 v3] Few more patches for Kumar's powerpc.git
Message-ID: <20080425170014.GA11669@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Here is the third try.

I've tried to address all the comments from the previous version.

The only comment I left out is merging mpc836x_rdk.c board file into some
existing board (as I explained, there are three QE boards: mpc832x_{rdb,mds}
and mpc836x_mds, and all have board-specific fixups either in the
machine_device_initcall()s or setup_arch()s, so I don't see an easy way to
merge RDK board into existing).

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
