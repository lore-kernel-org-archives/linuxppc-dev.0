Date: Fri, 30 May 2003 08:52:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: ?????? <jfg@ndsc.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: compiling error when compile kgdb on ppc 74XX
Message-ID: <20030530155219.GB3299@ip68-0-152-218.tc.ph.cox.net>
References: <7A7A7A38134E244784EDAC428C538AE90C6FC0@mail.ndsc.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7A7A7A38134E244784EDAC428C538AE90C6FC0@mail.ndsc.com.cn>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 30, 2003 at 09:34:07AM +0800, ?????? wrote:

>      I am a novice in Linux. I am trying to build kernel 2.4.17 for ppc on i386 using ppc_74xx-gcc cross compiler.  And the version of GCC is 2.96. The configuration compiles fine when I exclude kernel hacking options. Once kgdb option of the kernel hacking options is included, kernel compilation fails with the following:

2.4.17 on PPC, from kernel.org, only supports KGDB on 8xx.  If you need
kgdb on a 74xx board, I suggest you check out the linuxppc_2_4_devel
tree (see http://penguinppc.org/dev/kernel.shtml)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
