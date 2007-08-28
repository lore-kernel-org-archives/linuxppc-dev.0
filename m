Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FBA3DDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 02:54:27 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l7SGrLfk001520
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 20:53:21 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l7SGrLXx001517
	for linuxppc-dev@ozlabs.org; Tue, 28 Aug 2007 20:53:21 +0400
Date: Tue, 28 Aug 2007 20:53:21 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] PowerPC 440EPx: Initial Sequoia support take 3
Message-ID: <20070828165321.GA1501@ru.mvista.com>
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
The code is based mainly on the Bamboo board support by Josh Boyer.
These patches have been modified according the comments for the previous
440EPx Sequoia patch series.
