To: "Boerner, Brian" <bmb@pirus.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: breakpointing with bdi2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 23 Aug 2001 17:24:37 EDT."
             <200108232122.QAA24130@lists.linuxppc.org>
Date: Fri, 24 Aug 2001 00:41:45 +0200
Message-Id: <20010823224150.6FCA211265@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200108232122.QAA24130@lists.linuxppc.org> you wrote:
>
> 1. Power on the box and let ppcboot load my vmlinux file via tftp

You missed Step 0: RTFM.

> 2. start up gdb and do the following:

> (gdb) target remote bdi:2001
> Remote debugging using bdi:2001
> 0x1fd3540 in ?? ()
> (gdb) add-sym vmlinux 0xc0000000
> add symbol table from file "vmlinux" at
> 	.text_addr = 0xc0000000
> Reading symbols from vmlinux...done.
> (gdb) break mem_init
> Breakpoint 1 at 0xc014c424: file init.c, line 861.
> (gdb) c
> Continuing.
>
> 3. Pop back over to ppcboot and then type:
> bootm 00100000
>
> The kernel starts but never stops at mem_init. If I pop over to the telnet
> window for the bdi and manually stop the box I can step, but it won't break.

See the BDI2000 manual, especially section 3.3.4 Embedded  Linux  MMU
Support.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have made mistakes, but have never made the mistake of  claiming  I
never made one.                                     - James G. Bennet

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
