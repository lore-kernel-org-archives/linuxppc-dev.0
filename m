Message-ID: <396B3984.587964A7@pop.agri.ch>
Date: Tue, 11 Jul 2000 17:13:08 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test3 tree
References: <200007111505.QAA10603@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> The bk rsync 2.4.0-test3 tree is not compiling (timer.c)
> rsynced 16:00 BST [15:00 UTC/GMT]

kernel/timer.c line 580: if (p->nice > DEF_NICE) (ok)
arch/ppc/kernel/idle.c line 51: current->nice = 0; (not sure)

Runs here on a wallstreet.


Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
