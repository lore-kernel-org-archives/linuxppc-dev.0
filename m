Message-ID: <38E089AD.F415DCB7@freenet.de>
Date: Tue, 28 Mar 2000 12:30:06 +0200
From: christof <xfr@freenet.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel executing from flash
References: <1314024740.953824470340.JavaMail.wwwrun@moe.freenet.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My primary aim is not to gain speed or to save money, although this is
important for my application too.
By fetching opcodes from flash I expect more stability in temperature- and
emc-critical environement, for data in "ROM" is saver than in RAM. Of corse,
there is always run-time critical data in RAM (processor stack), but the
probability of "irrepairable" errors should decrease by runnig from flash.

Thanks for Your quick answers
Christof


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
