Message-ID: <3A05BE59.4AE7C5AE@mvista.com>
Date: Sun, 05 Nov 2000 15:08:57 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ron Avisa <ravisa@base2software.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: MMU probs in head.S w/821
References: <4.2.0.58.20001104202814.009b7180@pplus.shell9.ba.best.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ron Avisa wrote:

> Vision-ICE BDM might be problematic?

Yep.

> 821 has some strange MMU/cache problems (possibly related to alignment)?

Unlikely, unless you changed code in head.S and other places that
were not necessary.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
