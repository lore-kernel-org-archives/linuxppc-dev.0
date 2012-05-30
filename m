Return-Path: <giometti@enneenne.com>
Received: from goldrake.enneenne.com (unknown [78.110.190.154])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 50D00B7020
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 23:12:02 +1000 (EST)
Received: from localhost ([127.0.0.1] helo=enneenne.com)
 by goldrake.enneenne.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.72) (envelope-from <giometti@enneenne.com>)
 id 1SZee0-0002gX-DF
 for linuxppc-dev@lists.ozlabs.org; Wed, 30 May 2012 10:53:11 +0200
Resent-Message-ID: <20120530131123.GF3127@enneenne.com>
Date: Wed, 30 May 2012 14:02:57 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <20120530120257.GC3127@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Gianfar TX problems
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm working on a P1021MDS based board and I have a strange behaviour
regarding the TX packets from the gianfar driver (linux 3.0.4-rc5).

Rx is working correctly but Tx is not... in particular I noticed that
the buffer descriptors are correctly filled but the packets simply do
NOT exit form the TSEC (I looked at TSEC's tx counters)!

What is puzzling me is that sometimes both TX and RX work correctly
but most of the time only Rx is working! Again, testing the same
uImage on a Freescale P1021MDS devboard everything works well!

Maybe something related to DMA/RAM coherence?

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
