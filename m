Date: Mon, 23 Dec 2002 09:32:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: ???? <yuj@mail.ndsc.com.cn>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kgdb compile error
Message-ID: <20021223163237.GE15397@opus.bloom.county>
References: <200212200830.CAA05240@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212200830.CAA05240@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 20, 2002 at 04:35:06PM +0800, ???? wrote:

>   I want to debug the kernel with kgdb,so I build the kernel with CONFIG_KGDB.While there are something wrong with it.The error is listed below:

KGDB is not supported on the board you are compiling for.  Look at the
arch/ppc/kernel/gen550_*.c files for some pointers on where to start.  A
tested patch once you have KGDB working will be happily reviewed.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
