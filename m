Date: Mon, 17 Jul 2000 05:54:50 -0400
From: Dan Foster <dsf@gblx.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: dsf@gblx.net
Subject: Re: G4/500 cannot finish booting kernel - IDE and USB (strange)
Message-ID: <20000717055450.A25633@frontiernet.net>
References: <20000716112639.A2970@frontiernet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000716112639.A2970@frontiernet.net>; from dsf@gblx.net on Sun, Jul 16, 2000 at 11:26:39AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It is with a *very* sheepish look that I discover it's all because
I used BootX 1.2b3 rather than yaboot 0.6. I was initially under a
mistaken impression that yaboot could be installed only after Linux
had been set up... but I was wrong, and got everything working.

Much appreciated for the brain shake I got :-) And apologies for wasting
your time. I did, however, learn quite a few interesting things about
how the kernel is structured in 2.2.x.

-Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
