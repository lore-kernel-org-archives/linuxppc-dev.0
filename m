Date: Mon, 14 Jun 2004 23:19:31 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040614211931.GA21113@suse.de>
References: <20040605074341.GA15279@suse.de> <20040608112556.GA21447@suse.de> <20040610001605.GH18212@smtp.west.cox.net> <20040614091530.GA18482@suse.de> <20040614162359.GA7798@smtp.west.cox.net> <20040614173841.GA3247@suse.de> <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040614205537.GB7798@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Mon, Jun 14, Tom Rini wrote:

> ... except that we can have 'dssall' even when CONFIG_ALTIVEC=n, so we
> need it really on CONFIG_6xx.

switch_mm() has it in CONFIG_ALTIVEC, so checking for CONFIG_ALTIVEC=y
looks correct to me.

> But more importantly, why did you break the check to stop people with
> broken binutils from trying to compile the kernel, and not fix the rest
> of the breakage ?

What exactly is broken in the old binutils?
Is it this one?
 opcodes/ChangeLog-0203
2002-04-17  matthew green  <mrg@redhat.com>
        * ppc-opc.c (powerpc_opcode): Fix dssall operand list.

Or rev 1.21 in opcodes/ppc-opc.c? The current check seems to check just
for that one.

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
