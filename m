Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1A630DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 03:48:06 +1100 (EST)
Date: Mon, 6 Oct 2008 20:48:02 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/2] QE pin multiplexing API
Message-ID: <20081006164802.GA7105@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, David Miller <davem@davemloft.net>
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

The API is eveloved from the approach where I tried to put the
qe_set_dedicated() function into the GPIO LIB framework, which
wasn't good idea after all (see http://lkml.org/lkml/2008/9/24/289).

So here is the new version. Since the patchset touches driver/of/
I need Acks from the OF guys for the first patch. Then I hope
Kumar would merge the patchset to the powerpc-next. And after
that I could ask Greg KH to merge the FHCI driver itself...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
