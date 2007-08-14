Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF872DDDFC
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 04:42:12 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l7EIf8Wi008918
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 22:41:08 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l7EIf8fX008908
	for linuxppc-dev@ozlabs.org; Tue, 14 Aug 2007 22:41:08 +0400
Date: Tue, 14 Aug 2007 22:41:07 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] PowerPC 440EPx: Initial Sequoia support take 2
Message-ID: <20070814184107.GA6696@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches add initial PowerPC 440EPx Sequoia board support.
The code is based mainly on the Bamboo board support by Josh Boyer and
should be applied on top of the "[patch 00/10] 4xx patch series for 2.6.24"
which adds Bamboo support, since Sequoia shares some code pieces with Bamboo.
These patches have been modified based on the comments for the previous
440EPx Sequoia patch series.

The 2.6.24 4xx patch series is included in the following git tree:
git pull git://git.infradead.org/users/jwboyer/powerpc.git for-2.6.24

Thanks,
Valentine.
