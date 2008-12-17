Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 02BA7DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 07:06:12 +1100 (EST)
Date: Wed, 17 Dec 2008 23:06:10 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/7] Kdump support for classic PPC
Message-ID: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

This is Kdump part of the older series[1] posted few months ago.

Yeah, I didn't bother with relocatable kernel support (yet), I just
want to consolidate a position of the working Kdump implementation,
and then we can improve it as time goes by.

Other than that, all the comments that were previously made were
addressed in this series. Hope this can make it into 2.6.29.

Thanks,

[1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061161.html

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
