Date: Mon, 16 Jul 2001 08:07:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James Petterson <jpetterson@PARKS.com.br>,
	hychon <hychon@genetel.co.kr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: i can't use the function in kernel??
Message-ID: <20010716080721.B11496@opus.bloom.county>
References: <3B52C152.F5FB58B7@genetel.co.kr> <01071610105900.01193@james.parks.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01071610105900.01193@james.parks.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 16, 2001 at 10:10:59AM -0300, James Petterson wrote:

> If you're compiling a module, your output file should be 'network.o':
>
> ppc_8xx-gcc -o network.o network.c

Along with specifying lots of includes and -D__KERNEL__.  And the kernel
you'll be using this on needs modules enabled as well.  Run a 'make modules'
in your kernel tree and see what it uses to compile modules.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
