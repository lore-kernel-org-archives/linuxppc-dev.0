Date: Wed, 18 Jul 2001 23:56:27 +1000
From: Anton Blanchard <anton@samba.org>
To: kaoru Fukui <k_fukui@highway.ne.jp>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux kernel-2.4.7.pre7 from bk tree
Message-ID: <20010718235627.E3817@krispykreme>
References: <3B55931C.1D2678D8@highway.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B55931C.1D2678D8@highway.ne.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

> I have a promlem.
> here is

...

> smp.o(.sbss+0x14): multiple definition of `ipi_recv'
> irq.o(.sbss+0xc): first defined here
> smp.o: In function `ipi_sent':

2.4.7-pre7 added -fno-common to the compile flags. You can fix the
multiple definitions or take out -fno-common and wait for someone
else to fix it :)

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
