Date: Mon, 24 Jun 2002 14:42:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David C. Chiu" <dchiu@ariodata.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Enlarging Kernel Stack (doesn't this question ever go away?)
Message-ID: <20020624214255.GK3489@opus.bloom.county>
References: <8A098FDFC6EED94B872CA2033711F86F0EC041@orion.ariodata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F0EC041@orion.ariodata.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 24, 2002 at 01:50:07PM -0700, David C. Chiu wrote:

> What other thing needs to be done in addition to modifying
> INIT_TASK_SIZE in include/linux/sched.h? This is for the 405GP kernel.

Why are you trying to enlarge the stack?  This question never goes away
since it's almost always wrong to enlarge the stack...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
