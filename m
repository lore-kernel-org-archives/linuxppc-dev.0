Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 46257DDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 01:27:27 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 28B068810
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 20:27:25 +0500 (SAMST)
Date: Tue, 21 Aug 2007 19:27:45 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v5 0/2] SPI support for fsl_soc and mpc832x_rdb
Message-ID: <20070821152745.GA28986@localhost.localdomain>
References: <20070821134537.GA7428@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070821134537.GA7428@localhost.localdomain>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2007 at 05:45:37PM +0400, Anton Vorontsov wrote:
> Hi all,
> 
> Thanks for the previous reviews, this is v4 against Linus' tree,
> as of today.

Okay, here is brand-new, shiny v5. Today and only today it comes
without section mismatch warnings, don't miss your chance. Get it
free of charge! ;-)

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
