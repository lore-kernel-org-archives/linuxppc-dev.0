Message-ID: <3AD1FDDE.35D53285@mvista.com>
Date: Mon, 09 Apr 2001 14:22:22 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: machael thailer <dony.he@huawei.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc MMU problems...
References: <000b01c0c0dc$96cf9ae0$8021690a@huawei.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


machael thailer wrote:

>       I want to know whether the ICache and DCache is enabled or disabled in
> linuxppc kernel(2.4.3-pre4) and how can I do it (in which file)?


The caches are always enabled, and could be done in a variety of
ways, sometimes even from the boot rom that starts the Linux kernel.
It would help if you were a little more explicit about the processor
and board you are using.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
